import pytest
import tempfile

from code_advent.year_2017 import day_02


@pytest.fixture
def sheet_blob():
    return (
        "5\t1\t9\t5\n"
        "7\t5\t3\n"
        "2\t4\t6\t8"
    )


@pytest.fixture
def input_file(sheet_blob):
    with tempfile.NamedTemporaryFile(mode='w') as f:
        f.write(sheet_blob)
        f.flush()
        f.seek(0)

        yield f.name


@pytest.fixture
def checksum_result():
    return 18


def test_checksum(input_file, checksum_result):
    assert day_02.checksum(sheet_file=input_file) == checksum_result
