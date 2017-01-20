import pytest


@pytest.fixture
def dummy():
    return 'foo'


def test_dummy(dummy):
    assert dummy == 'foo'
