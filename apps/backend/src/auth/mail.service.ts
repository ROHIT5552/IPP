import { BadRequestException, Injectable, Logger } from "@nestjs/common";
import { AccessLeadEmail, SignInCodeEmail, accessDecisionTemplate, accessRequestTemplate, signInCodeTemplate } from "./email-templates";

const BREVO_URL = "https://api.brevo.com/v3/smtp/email";
const DEFAULT_SENDER = "notifications@example.com";

export function superAdminEmail() {
  return process.env.SUPERADMIN_EMAIL?.trim() || "admin@example.com";
}

@Injectable()
export class MailService {
  private readonly logger = new Logger(MailService.name);

  async sendSignInCode(input: SignInCodeEmail) {
    const message = signInCodeTemplate(input);
    const templateId = Number(process.env.BREVO_SIGNIN_TEMPLATE_ID || 0);
    return templateId > 0
      ? this.deliver({ to: input.to, name: input.name, templateId, params: message.params, tag: "ges-sign-in" })
      : this.deliver({ to: input.to, name: input.name, subject: message.subject, html: message.html, text: message.text, tag: "ges-sign-in" });
  }

  async sendAccessRequest(input: AccessLeadEmail) {
    const message = accessRequestTemplate(input);
    return this.deliver({
      to: superAdminEmail(),
      name: "NewRa Grids",
      subject: message.subject,
      html: message.html,
      text: message.text,
      tag: "ges-access-request",
    });
  }

  async sendAccessDecision(to: string, name: string, gesName: string, accepted: boolean) {
    const message = accessDecisionTemplate({ name, gesName, accepted });
    return this.deliver({
      to,
      name,
      subject: message.subject,
      html: message.html,
      text: message.text,
      tag: accepted ? "ges-access-approved" : "ges-access-rejected",
    });
  }

  private async deliver(input: {
    to: string;
    name: string;
    subject?: string;
    html?: string;
    text?: string;
    templateId?: number;
    params?: Record<string, string>;
    tag: string;
  }) {
    const apiKey = process.env.BREVO_API_KEY?.trim();
    const senderEmail = process.env.BREVO_SENDER_EMAIL?.trim() || DEFAULT_SENDER;
    if (!apiKey) {
      this.logger.warn(`Brevo API key is not set. Email to ${input.to} was not sent. Subject: ${input.subject ?? "template"}`);
      return { delivery: "logged" as const };
    }
    const sender = { name: process.env.BREVO_SENDER_NAME?.trim() || "NewRa Grids", email: senderEmail };
    const payload = input.templateId
      ? { sender, to: [{ email: input.to, name: input.name }], templateId: input.templateId, params: input.params, tags: [input.tag] }
      : { sender, to: [{ email: input.to, name: input.name }], subject: input.subject, htmlContent: input.html, textContent: input.text, tags: [input.tag] };
    const response = await fetch(BREVO_URL, {
      method: "POST",
      headers: { accept: "application/json", "content-type": "application/json", "api-key": apiKey },
      body: JSON.stringify(payload),
    });
    if (!response.ok) {
      const detail = await response.text();
      this.logger.error(`Brevo rejected email to ${input.to} (${response.status}): ${detail}`);
      throw new BadRequestException("The email could not be sent. Try again in a moment.");
    }
    return { delivery: "sent" as const };
  }
}
