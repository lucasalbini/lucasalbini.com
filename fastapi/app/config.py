from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    strapi_base_url: str = "http://strapi:1337"
    strapi_api_token: str = ""

    fastapi_host: str = "0.0.0.0"
    fastapi_port: int = 8000

    cache_ttl: int = 300

    # Used by webhooks to trigger Next revalidation. Both required for revalidation to fire.
    next_url: str = "http://frontend:3000"
    revalidate_secret: str = ""

    # Shared secret with Strapi webhook config. If empty, no signature check happens
    # (development only — set this in production).
    strapi_webhook_secret: str = ""

    # Per-IP contact form limits.
    contact_max_per_hour: int = 5

    default_locale: str = "pt-BR"
    supported_locales: tuple[str, ...] = ("pt-BR", "en")

    model_config = SettingsConfigDict(env_file=".env", extra="ignore")


settings = Settings()
