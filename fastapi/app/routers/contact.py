from __future__ import annotations

import logging

from fastapi import APIRouter, HTTPException, Request

from app.config import settings
from app.schemas.contact import ContactAck, ContactMessage
from app.services.rate_limit import RateLimiter

router = APIRouter(prefix="/contact", tags=["contact"])
log = logging.getLogger(__name__)

_limiter = RateLimiter(max_per_hour=settings.contact_max_per_hour)


@router.post("", response_model=ContactAck, status_code=202)
async def send_contact(request: Request, msg: ContactMessage):
    client_ip = request.client.host if request.client else "unknown"
    if not _limiter.check(client_ip):
        raise HTTPException(status_code=429, detail="too many requests")
    # Delivery integration lives here once we pick a provider (SES/Resend/etc).
    # For now, log so the message isn't silently dropped in dev.
    log.info("contact from %s: name=%s email=%s len=%d", client_ip, msg.name, msg.email, len(msg.message))
    return ContactAck()
