"""Post body blocks: Strapi dynamic-zone components → typed DTOs.

Each Strapi component `blocks.<name>` becomes `{"type": "<name>", ...}`. Blocks that
can't be rendered (unknown component, required media deleted, no places left) are
dropped here, so the frontend never has to guess what to do with half a block.
"""

from __future__ import annotations

from collections.abc import Callable
from typing import Annotated, Any, Literal

from pydantic import Field

from app.schemas.common import BaseDTO, Media, normalize_media, normalize_media_list
from app.schemas.place import Place, to_place


class TextBlock(BaseDTO):
    type: Literal["text"] = "text"
    body: list = []


class ImageBlock(BaseDTO):
    type: Literal["image"] = "image"
    image: Media
    caption: str | None = None
    layout: Literal["column", "wide", "full"] = "column"


class GalleryBlock(BaseDTO):
    type: Literal["gallery"] = "gallery"
    images: list[Media]
    caption: str | None = None


class YoutubeBlock(BaseDTO):
    type: Literal["youtube"] = "youtube"
    url: str
    caption: str | None = None


class InstagramBlock(BaseDTO):
    type: Literal["instagram"] = "instagram"
    url: str
    caption: str | None = None


class PlacesBlock(BaseDTO):
    type: Literal["places"] = "places"
    title: str | None = None
    places: list[Place]


class DownloadBlock(BaseDTO):
    type: Literal["download"] = "download"
    file: Media
    label: str
    description: str | None = None


class LinkBlock(BaseDTO):
    type: Literal["link"] = "link"
    url: str
    title: str
    description: str | None = None


class CalloutBlock(BaseDTO):
    type: Literal["callout"] = "callout"
    body: str
    tone: Literal["note", "tip", "warning"] = "note"


Block = Annotated[
    TextBlock
    | ImageBlock
    | GalleryBlock
    | YoutubeBlock
    | InstagramBlock
    | PlacesBlock
    | DownloadBlock
    | LinkBlock
    | CalloutBlock,
    Field(discriminator="type"),
]


def _text(raw: dict[str, Any]) -> TextBlock | None:
    body = raw.get("body") or []
    return TextBlock(body=body) if body else None


def _image(raw: dict[str, Any]) -> ImageBlock | None:
    image = normalize_media(raw.get("image"))
    if not image:
        return None
    return ImageBlock(image=image, caption=raw.get("caption"), layout=raw.get("layout") or "column")


def _gallery(raw: dict[str, Any]) -> GalleryBlock | None:
    images = normalize_media_list(raw.get("images"))
    return GalleryBlock(images=images, caption=raw.get("caption")) if images else None


def _youtube(raw: dict[str, Any]) -> YoutubeBlock | None:
    return YoutubeBlock(url=raw["url"], caption=raw.get("caption")) if raw.get("url") else None


def _instagram(raw: dict[str, Any]) -> InstagramBlock | None:
    return InstagramBlock(url=raw["url"], caption=raw.get("caption")) if raw.get("url") else None


def _places(raw: dict[str, Any]) -> PlacesBlock | None:
    places = [p for p in (to_place(r) for r in (raw.get("places") or [])) if p]
    return PlacesBlock(title=raw.get("title"), places=places) if places else None


def _download(raw: dict[str, Any]) -> DownloadBlock | None:
    file = normalize_media(raw.get("file"))
    if not file:
        return None
    return DownloadBlock(
        file=file, label=raw.get("label") or file.name or "Download", description=raw.get("description")
    )


def _link(raw: dict[str, Any]) -> LinkBlock | None:
    if not raw.get("url"):
        return None
    return LinkBlock(url=raw["url"], title=raw.get("title") or raw["url"], description=raw.get("description"))


def _callout(raw: dict[str, Any]) -> CalloutBlock | None:
    return CalloutBlock(body=raw["body"], tone=raw.get("tone") or "note") if raw.get("body") else None


_BUILDERS: dict[str, Callable[[dict[str, Any]], BaseDTO | None]] = {
    "blocks.text": _text,
    "blocks.image": _image,
    "blocks.gallery": _gallery,
    "blocks.youtube": _youtube,
    "blocks.instagram": _instagram,
    "blocks.places": _places,
    "blocks.download": _download,
    "blocks.link": _link,
    "blocks.callout": _callout,
}

BLOCK_COMPONENTS = tuple(_BUILDERS)


def to_blocks(raw_body: Any) -> list[BaseDTO]:
    if not isinstance(raw_body, list):
        return []
    blocks: list[BaseDTO] = []
    for raw in raw_body:
        builder = _BUILDERS.get(raw.get("__component", "")) if isinstance(raw, dict) else None
        block = builder(raw) if builder else None
        if block is not None:
            blocks.append(block)
    return blocks


def body_populate() -> dict[str, Any]:
    """Populate for the `body` dynamic zone. Every component gets its first-level media and
    relations; places go one level deeper for their photo."""
    on: dict[str, Any] = {name: True for name in BLOCK_COMPONENTS}
    on["blocks.places"] = {"populate": {"places": {"populate": {"photo": True}}}}
    return {"on": on}


def word_count(blocks: list[BaseDTO]) -> int:
    words = 0
    for block in blocks:
        if isinstance(block, TextBlock):
            words += _count_rich_text(block.body)
        elif isinstance(block, CalloutBlock):
            words += len(block.body.split())
    return words


def _count_rich_text(nodes: list) -> int:
    words = 0
    for node in nodes:
        if not isinstance(node, dict):
            continue
        text = node.get("text")
        if isinstance(text, str):
            words += len(text.split())
        words += _count_rich_text(node.get("children") or [])
    return words
