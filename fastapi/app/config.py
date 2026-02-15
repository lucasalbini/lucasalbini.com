from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    strapi_base_url: str = "http://strapi:1337"
    strapi_api_token: str = ""
    fastapi_host: str = "0.0.0.0"
    fastapi_port: int = 8000
    cache_ttl: int = 300

    class Config:
        env_file = ".env"


settings = Settings()
