import { Body, Controller, Get, Post, Req, Res } from "@nestjs/common";
import { IsEmail, IsString, MinLength } from "class-validator";
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

@Controller("auth")
export class AuthController {
  constructor(private readonly auth: AuthService) {}

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
