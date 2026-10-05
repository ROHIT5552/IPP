export interface SignInCodeEmail {
  to: string;
  name: string;
  gesName: string;
  code: string;
  requestedAt: Date;
  expiresAt: Date;
  resendSeconds: number;
  reason?: "signin" | "signup" | "profile";
}

const ZONE = "Asia/Kolkata";

export function signInCodeTemplate(input: SignInCodeEmail) {
  const name = escapeHtml(input.name);
  const gesName = escapeHtml(input.gesName);
  const email = escapeHtml(input.to);
  const requestedAt = formatWhen(input.requestedAt);
  const expiresAt = formatWhen(input.expiresAt);
  const digits = input.code.split("").map((digit) => `<td style="width:52px;height:58px;border:1px solid #d5e2ea;border-radius:10px;background:#f4faf8;text-align:center;font:700 28px/58px Arial,sans-serif;color:#102033;letter-spacing:0">${escapeHtml(digit)}</td>`).join('<td style="width:8px"></td>');
  const reason = input.reason ?? "signin";
  const headline = reason === "signup"
    ? "Finish creating your profile"
    : reason === "profile"
      ? `Add your profile to ${gesName}`
      : `Sign in to ${gesName}`;
  const lead = reason === "signup"
    ? `use this code to finish creating your NewRa profile for ${gesName}.`
    : reason === "profile"
      ? `use this code to add your profile to ${gesName}.`
      : `a sign-in was just requested for your GES workspace. Enter this 4-digit code on the NewRa sign-in screen.`;
  const subject = reason === "signup"
    ? `${input.code} is your NewRa sign-up code`
    : reason === "profile"
      ? `${input.code} confirms your NewRa profile`
      : `${input.code} is your NewRa sign-in code`;
  const text = [
    `Hello ${input.name},`,
    "",
    reason === "signup"
      ? `Use this code to finish creating your NewRa profile for ${input.gesName}.`
      : reason === "profile"
        ? `Use this code to add your profile to ${input.gesName}.`
        : `Use this code to sign in to ${input.gesName} on NewRa.`,
    "",
    input.code,
    "",
    `Requested: ${requestedAt}`,
    `Expires: ${expiresAt} (5 minutes)`,
    `You can request another code ${input.resendSeconds} seconds after this email.`,
    "This code works once.",
    "",
    "If you did not try to sign in, ignore this email.",
    "",
    `Sent to ${input.to}`,
    "NewRa Energy Decision Platform",
  ].join("\n");
  const html = `<!DOCTYPE html>
<html lang="en">
<body style="margin:0;padding:0;background:#eef3f6">
  <div style="display:none;max-height:0;overflow:hidden">Sign in to ${gesName}. This code expires at ${escapeHtml(expiresAt)}.</div>
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#eef3f6;padding:28px 12px">
    <tr><td align="center">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;background:#ffffff;border-radius:16px;overflow:hidden">
        <tr><td style="padding:22px 28px;background:#071018;color:#f7fbff;font:800 22px Arial,sans-serif">newra<span style="color:#e0a45a">.</span></td></tr>
        <tr><td style="padding:28px 28px 8px;font:700 22px Arial,sans-serif;color:#102033">${headline}</td></tr>
        <tr><td style="padding:8px 28px 0;font:16px/1.6 Arial,sans-serif;color:#3d4d5c">Hello ${name}, ${lead}</td></tr>
        <tr><td style="padding:22px 28px 6px">
          <table role="presentation" cellpadding="0" cellspacing="0"><tr>${digits}</tr></table>
        </td></tr>
        <tr><td style="padding:8px 28px 0;font:14px/1.6 Arial,sans-serif;color:#3d4d5c">
          Requested ${escapeHtml(requestedAt)}<br>
          Expires ${escapeHtml(expiresAt)} — 5 minutes from the request<br>
          A new code can be sent ${input.resendSeconds} seconds after this one<br>
          The code can be used once
        </td></tr>
        <tr><td style="padding:18px 28px 28px;font:14px/1.6 Arial,sans-serif;color:#5c6b7a">If you did not try to sign in, you can ignore this email. Nobody can enter the workspace without this code.</td></tr>
        <tr><td style="padding:16px 28px 22px;background:#f6f8f8;font:12px/1.5 Arial,sans-serif;color:#6a7a86">Sent to ${email}<br>NewRa Energy Decision Platform</td></tr>
      </table>
    </td></tr>
  </table>
</body>
</html>`;
  return {
    subject,
    text,
    html,
    params: {
      NAME: input.name,
      GES_NAME: input.gesName,
      CODE: input.code,
      EMAIL: input.to,
      REQUESTED_AT: requestedAt,
      EXPIRES_AT: expiresAt,
      EXPIRES_MINUTES: "5",
      RESEND_SECONDS: String(input.resendSeconds),
    },
  };
}

export interface AccessLeadEmail {
  name: string;
  email: string;
  phone: string;
  gesName: string;
  requestedAt: Date;
}

export function accessRequestTemplate(input: AccessLeadEmail) {
  const when = formatWhen(input.requestedAt);
  const name = escapeHtml(input.name);
  const email = escapeHtml(input.email);
  const phone = escapeHtml(input.phone);
  const gesName = escapeHtml(input.gesName);
  const subject = `GES access request: ${input.name}`;
  const text = [
    "A GES user is waiting for access.",
    "",
    `Name: ${input.name}`,
    `Email: ${input.email}`,
    `Phone: ${input.phone}`,
    `Organisation: ${input.gesName}`,
    `Requested: ${when}`,
    "",
    "Approve this lead in NewRa under GES access. They cannot open the workspace until you accept.",
  ].join("\n");
  const html = `<!DOCTYPE html>
<html lang="en"><body style="margin:0;padding:0;background:#eef3f6">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#eef3f6;padding:28px 12px"><tr><td align="center">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;background:#ffffff;border-radius:16px;overflow:hidden">
      <tr><td style="padding:22px 28px;background:#071018;color:#f7fbff;font:800 22px Arial,sans-serif">newra<span style="color:#e0a45a">.</span></td></tr>
      <tr><td style="padding:28px 28px 8px;font:700 22px Arial,sans-serif;color:#102033">GES access permission</td></tr>
      <tr><td style="padding:8px 28px 0;font:16px/1.6 Arial,sans-serif;color:#3d4d5c">A person asked to use NewRa for their GES. They stay locked out until you accept.</td></tr>
      <tr><td style="padding:16px 28px;font:15px/1.7 Arial,sans-serif;color:#102033">
        <strong>Name:</strong> ${name}<br>
        <strong>Email:</strong> ${email}<br>
        <strong>Phone:</strong> ${phone}<br>
        <strong>Organisation:</strong> ${gesName}<br>
        <strong>Requested:</strong> ${escapeHtml(when)}
      </td></tr>
      <tr><td style="padding:0 28px 28px;font:14px/1.6 Arial,sans-serif;color:#5c6b7a">Open GES access in NewRa to accept or remove this user. The phone number is the lead reference.</td></tr>
    </table>
  </td></tr></table>
</body></html>`;
  return { subject, text, html };
}

export function accessDecisionTemplate(input: { name: string; gesName: string; accepted: boolean }) {
  const name = escapeHtml(input.name);
  const gesName = escapeHtml(input.gesName);
  const subject = input.accepted
    ? `Your NewRa access for ${input.gesName} is approved`
    : `Your NewRa access for ${input.gesName} was not approved`;
  const text = input.accepted
    ? `Hello ${input.name},\n\nNewRa Grids approved your access to ${input.gesName}. Sign in with this email and use the code we send you.\n`
    : `Hello ${input.name},\n\nNewRa Grids did not approve access to ${input.gesName}. You cannot open that workspace.\n`;
  const html = `<!DOCTYPE html>
<html lang="en"><body style="margin:0;padding:0;background:#eef3f6">
  <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#eef3f6;padding:28px 12px"><tr><td align="center">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:560px;background:#ffffff;border-radius:16px;overflow:hidden">
      <tr><td style="padding:22px 28px;background:#071018;color:#f7fbff;font:800 22px Arial,sans-serif">newra<span style="color:#e0a45a">.</span></td></tr>
      <tr><td style="padding:28px 28px 8px;font:700 22px Arial,sans-serif;color:#102033">${input.accepted ? "Access approved" : "Access not approved"}</td></tr>
      <tr><td style="padding:8px 28px 28px;font:16px/1.6 Arial,sans-serif;color:#3d4d5c">Hello ${name}, ${input.accepted
        ? `NewRa Grids approved your GES role for ${gesName}. Sign in with this email address. We will send a 4-digit code.`
        : `NewRa Grids did not approve your GES role for ${gesName}. You cannot open the workspace.`}
      </td></tr>
    </table>
  </td></tr></table>
</body></html>`;
  return { subject, text, html };
}

function formatWhen(value: Date) {
  return new Intl.DateTimeFormat("en-IN", {
    timeZone: ZONE,
    day: "numeric",
    month: "short",
    year: "numeric",
    hour: "numeric",
    minute: "2-digit",
    hour12: true,
    timeZoneName: "short",
  }).format(value);
}

function escapeHtml(value: string) {
  return value
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;");
}
