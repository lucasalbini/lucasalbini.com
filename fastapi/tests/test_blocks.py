from typing import Any

from app.schemas.blocks import (
    CalloutBlock,
    DownloadBlock,
    GalleryBlock,
    ImageBlock,
    PlacesBlock,
    TextBlock,
    body_populate,
    to_blocks,
    word_count,
)
from app.services.strapi_client import _flatten_populate

IMAGE = {"url": "/uploads/a.jpg", "width": 800, "height": 600}
PLACE = {
    "documentId": "p1",
    "name": "Ver-o-Peso",
    "slug": "ver-o-peso",
    "kind": "attraction",
    "latitude": -1.4525,
    "longitude": -48.5034,
}


def paragraph(text: str) -> dict[str, Any]:
    return {"type": "paragraph", "children": [{"type": "text", "text": text}]}


def test_component_name_becomes_block_type() -> None:
    blocks = to_blocks([{"__component": "blocks.youtube", "id": 1, "url": "https://youtu.be/x"}])

    assert [b.model_dump()["type"] for b in blocks] == ["youtube"]


def test_blocks_keep_the_order_written_in_the_admin() -> None:
    raw = [
        {"__component": "blocks.callout", "body": "Leve capa de chuva", "tone": "tip"},
        {"__component": "blocks.text", "body": [paragraph("Cheguei numa quinta")]},
        {"__component": "blocks.image", "image": IMAGE},
    ]

    assert [type(b) for b in to_blocks(raw)] == [CalloutBlock, TextBlock, ImageBlock]


def test_unknown_component_is_dropped_instead_of_breaking_the_post() -> None:
    raw = [{"__component": "blocks.poll", "question": "?"}, {"__component": "blocks.text", "body": [paragraph("oi")]}]

    assert [type(b) for b in to_blocks(raw)] == [TextBlock]


def test_image_whose_media_was_deleted_is_dropped() -> None:
    assert to_blocks([{"__component": "blocks.image", "image": None, "caption": "sumiu"}]) == []


def test_image_layout_defaults_to_reading_column() -> None:
    (block,) = to_blocks([{"__component": "blocks.image", "image": IMAGE, "layout": None}])

    assert isinstance(block, ImageBlock) and block.layout == "column"


def test_gallery_skips_entries_without_url() -> None:
    (block,) = to_blocks([{"__component": "blocks.gallery", "images": [IMAGE, {"url": None}, IMAGE]}])

    assert isinstance(block, GalleryBlock) and len(block.images) == 2


def test_places_without_coordinates_are_left_off_the_map() -> None:
    no_coords = {**PLACE, "slug": "sem-coord", "latitude": None}
    (block,) = to_blocks([{"__component": "blocks.places", "title": "Onde comi", "places": [PLACE, no_coords]}])

    assert isinstance(block, PlacesBlock) and [p.slug for p in block.places] == ["ver-o-peso"]


def test_places_block_with_no_mappable_place_is_dropped() -> None:
    assert to_blocks([{"__component": "blocks.places", "places": []}]) == []


def test_download_without_label_falls_back_to_file_name() -> None:
    (block,) = to_blocks([{"__component": "blocks.download", "file": {**IMAGE, "name": "roteiro.pdf"}, "label": ""}])

    assert isinstance(block, DownloadBlock) and block.label == "roteiro.pdf"


def test_non_list_body_yields_no_blocks() -> None:
    assert to_blocks(None) == []


def test_word_count_reads_nested_rich_text_and_callouts() -> None:
    nested_list = {
        "type": "list",
        "children": [{"type": "list-item", "children": [{"type": "text", "text": "um dois"}]}],
    }
    blocks = to_blocks(
        [
            {"__component": "blocks.text", "body": [paragraph("três quatro cinco"), nested_list]},
            {"__component": "blocks.callout", "body": "seis sete"},
        ]
    )

    assert word_count(blocks) == 7


def test_body_populate_reaches_place_photos() -> None:
    params = _flatten_populate({"body": body_populate()})

    assert params["populate[body][on][blocks.places][populate][places][populate][photo][populate]"] == "*"
    assert params["populate[body][on][blocks.gallery][populate]"] == "*"
