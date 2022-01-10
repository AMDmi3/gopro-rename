FLAKE8?=	flake8
MYPY?=		mypy
ISORT?=		isort

lint: flake8 mypy isort-check test

flake8::
	${FLAKE8} gopro-rename

mypy::
	${MYPY} gopro-rename

isort-check::
	${ISORT} --check gopro-rename

isort::
	${ISORT} gopro-rename

test::
	./test.sh
