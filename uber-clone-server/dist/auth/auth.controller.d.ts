import { LoginDto } from './dtos/login.dto';
export declare class AuthController {
    login(body: LoginDto): {
        status: number;
        message: string;
        user: {
            name: string;
            email: string;
            token: string;
        };
    };
}
