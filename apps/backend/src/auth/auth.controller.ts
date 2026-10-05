import { Body, Controller, Delete, Get, Param, Post, Req, Res } from "@nestjs/common";
import { IsEmail, IsString, Matches, MinLength } from "class-validator";
import { Request, Response } from "express";
import { Public } from "../common/http";
import { AuthService } from "./auth.service";

class LoginDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(8)
  password!: string;
}

class GesOtpDto {
  @IsString()
  @MinLength(2)
  profileId!: string;
}

class VerifyGesOtpDto extends GesOtpDto {
  @Matches(/^\d{4}$/)
  code!: string;
}

class EmailDto {
  @IsEmail()
  email!: string;
}

class SignupDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(2)
  name!: string;

  @IsString()
  @MinLength(2)
  gesName!: string;

  @IsString()
  @MinLength(10)
  phone!: string;
}

class AddGesUserDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(2)
  name!: string;

  @IsString()
  @MinLength(10)
  phone!: string;

  @IsString()
  @MinLength(2)
  gesId!: string;
}

class SignupVerifyDto extends EmailDto {
  @Matches(/^\d{4}$/)
  code!: string;
}

class AddProfileDto {
  @IsEmail()
  email!: string;

  @IsString()
  @MinLength(2)
  name!: string;

  @IsString()
  @MinLength(10)
  phone!: string;
}

@Controller("auth")
export class AuthController {
  constructor(private readonly auth: AuthService) {}

  @Public()
  @Get("ges-profiles")
  gesProfiles() {
    return this.auth.gesProfiles();
  }

  @Public()
  @Post("ges-otp/email")
  requestGesOtpByEmail(@Body() body: EmailDto) {
    return this.auth.requestGesOtpByEmail(body.email);
  }

  @Public()
  @Post("ges-otp")
  requestGesOtp(@Body() body: GesOtpDto) {
    return this.auth.requestGesOtp(body.profileId);
  }

  @Public()
  @Post("signup")
  startSignup(@Body() body: SignupDto) {
    return this.auth.startSignup(body);
  }

  @Public()
  @Post("signup/verify")
  verifySignup(@Body() body: SignupVerifyDto) {
    return this.auth.verifySignup(body.email, body.code);
  }

  @Get("ges-access")
  listGesAccess(@Req() request: Request & { user: { roles?: string[] } }) {
    return this.auth.listGesAccess(request.user);
  }

  @Post("ges-access")
  addGesUser(@Req() request: Request & { user: { roles?: string[] } }, @Body() body: AddGesUserDto) {
    return this.auth.addGesUser(request.user, body);
  }

  @Post("ges-access/:userId/approve")
  approveGesUser(@Req() request: Request & { user: { roles?: string[] } }, @Param("userId") userId: string) {
    return this.auth.decideGesAccess(request.user, userId, true);
  }

  @Post("ges-access/:userId/reject")
  rejectGesUser(@Req() request: Request & { user: { roles?: string[] } }, @Param("userId") userId: string) {
    return this.auth.decideGesAccess(request.user, userId, false);
  }

  @Delete("ges-access/:userId")
  removeGesUser(@Req() request: Request & { user: { roles?: string[] } }, @Param("userId") userId: string) {
    return this.auth.decideGesAccess(request.user, userId, false);
  }

  @Get("household")
  household(@Req() request: Request & { user: { gesId?: string | null } }) {
    return this.auth.household(request.user);
  }

  @Post("profiles")
  addProfile(@Req() request: Request & { user: { gesId?: string | null } }, @Body() body: AddProfileDto) {
    return this.auth.addProfile(request.user, body);
  }

  @Public()
  @Post("profiles/verify")
  verifyAddedProfile(@Body() body: SignupVerifyDto) {
    return this.auth.verifyAddedProfile(body.email, body.code);
  }

  @Public()
  @Post("ges-otp/verify")
  verifyGesOtp(@Body() body: VerifyGesOtpDto, @Res({ passthrough: true }) response: Response) {
    return this.auth.verifyGesOtp(body.profileId, body.code, response);
  }

  @Public()
  @Post("login")
  login(@Body() body: LoginDto, @Res({ passthrough: true }) response: Response) {
    return this.auth.login(body.email, body.password, response);
  }

  @Public()
  @Post("refresh")
  refresh(@Req() request: Request, @Res({ passthrough: true }) response: Response) {
    return this.auth.refresh(request.cookies?.newra_refresh, response);
  }

  @Public()
  @Post("logout")
  logout(@Req() request: Request, @Res({ passthrough: true }) response: Response) {
    return this.auth.logout(request.cookies?.newra_refresh, response);
  }

  @Get("me")
  me(@Req() request: Request & { user: unknown }) {
    return request.user;
  }
}
