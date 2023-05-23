.PHONY: get test

get:
	flutter pub get

test:
	flutter test

gen:
	dart run build_runner build --delete-conflicting-outputs

gen-all: gen
	flutter gen-l10n
