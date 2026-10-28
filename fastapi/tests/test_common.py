from app.schemas.common import normalize_media, normalize_media_list


def test_media_list_field_takes_the_first_item() -> None:
    media = normalize_media([{"url": "/a.jpg"}, {"url": "/b.jpg"}])

    assert media is not None and media.url == "/a.jpg"


def test_empty_media_is_none() -> None:
    assert normalize_media([]) is None
    assert normalize_media(None) is None


def test_media_list_ignores_non_list_input() -> None:
    assert normalize_media_list({"url": "/a.jpg"}) == []
