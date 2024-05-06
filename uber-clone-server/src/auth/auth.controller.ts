import { Body, Controller, Post, UnauthorizedException } from '@nestjs/common';
import { LoginDto } from './dtos/login.dto';

@Controller('auth')
export class AuthController {
  // TODO - currently only for testing
  @Post('/login')
  login(@Body() body: LoginDto) {
    console.log('Receiving request with body:', body);

    const { email, password } = body;

    if (email === 'darkphoton20@gmail.com' && password === '123456') {
      return {
        status: 200,
        message: 'User successfully logged in.',
        user: {
          name: 'Kranti Nebhwani',
          email: 'darkphoton20@gmail.com',
          token: '123',
        },
      };
    } else {
      throw new UnauthorizedException('Credentials were incorrect.');
    }
  }
}
