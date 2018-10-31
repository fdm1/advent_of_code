# pylint: disable=missing-docstring,redefined-outer-name
import pytest
import tempfile

from code_advent.year_2017 import day_02


@pytest.fixture
def sheet_blob():
    return (
        "5\t9\t2\t8\n"
        "9\t4\t7\t3\n"
        "3\t8\t6\t5"
    )


@pytest.fixture
def input_file(sheet_blob):
    with tempfile.NamedTemporaryFile(mode='w') as f:
        f.write(sheet_blob)
        f.flush()
        f.seek(0)

        yield f.name


@pytest.fixture
def checksum_min_max_result():
    return 18


@pytest.fixture
def checksum_even_divisible_result():
    return 9


def test_checksum_min_max(input_file, checksum_min_max_result):
    assert day_02.checksum_min_max(sheet_file=input_file) == checksum_min_max_result


def test_checksum_even_divisible(input_file, checksum_even_divisible_result):
    assert day_02.checksum_even_divisible(sheet_file=input_file) == checksum_even_divisible_result
