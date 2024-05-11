package com.example.crm.util;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.DecodedJWT;
import lombok.Data;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Component
public class jwtTool {

    private static final long EXPIRE =  60 * 60*100000 ;

    private static final String TOKEN_PREFIX = "Bearer";

    public static String getToken(String username,String password){

        String token="";

        try {

            Date nowDate = new Date(System.currentTimeMillis()+EXPIRE);

            Map<String,Object>header= new HashMap<>();

            header.put("typ","JWT");

            header.put("alg","HS256");

            Algorithm algorithm = Algorithm.HMAC256(TOKEN_PREFIX);

            token= JWT.create()
                    .withHeader(header)
                    .withClaim("username",username)
                    .withClaim("password",password)
                    .withExpiresAt(nowDate)
                    .sign(algorithm);

        }catch (Exception e){
            e.printStackTrace();
            return null;
        }
        return token;
    }

    public static boolean verify(String token){

        try {

            Algorithm algorithm=Algorithm.HMAC256(TOKEN_PREFIX);

            JWTVerifier verifier=JWT.require(algorithm).build();

            System.out.println("before verify");

            DecodedJWT jwt = verifier.verify(token);

            System.out.println("after verify");

            return true;

        }catch (Exception e){

            System.out.println("token认证失败");

            e.printStackTrace();

            return false;

        }
    }

}
