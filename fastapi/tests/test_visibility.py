from app.services.visibility import LISTED, REACHABLE, visibility_filter


def test_lists_only_show_public_posts() -> None:
    assert visibility_filter(LISTED) == {"filters[visibility][$in][0]": "public"}


def test_direct_links_reach_public_and_unlisted_but_never_private() -> None:
    allowed = set(visibility_filter(REACHABLE).values())

    assert allowed == {"public", "unlisted"}


def test_filter_can_target_a_nested_path() -> None:
    assert visibility_filter(LISTED, path="filters[$and][1][visibility]") == {
        "filters[$and][1][visibility][$in][0]": "public"
    }
