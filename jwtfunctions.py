import jwt

import os

# Private RSA Key for testing
private_key = open("private.pem", "rb").read()

public_key = open("public.pem", "rb").read()

def encode(user):
    token = jwt.encode({"user": user}, private_key, algorithm="RS256")
    print("Token: " + token)
    return token
