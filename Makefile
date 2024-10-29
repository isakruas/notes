# Makefile for Note Publication

# Project name
PROJECT_NAME := Personal Notes

# Directory where notes will be stored
NOTES_DIR := ./notes

# List of notes
NOTES := $(wildcard $(NOTES_DIR)/*.md)

# Default target
.PHONY: all clean add list help

# Display help information
help:
	@echo "Usage:"
	@echo "  make all       - Build all notes"
	@echo "  make add       - Add a new note"
	@echo "  make list      - List all notes"
	@echo "  make edit      - Edit an existing note"
	@echo "  make clean     - Remove all notes"
	@echo "  make help      - Show this help message"

# Build all notes
all: $(NOTES)

# Add a new note
add:
	@ \
	if [ -z "$$TITLE" ]; then \
		if [ -z "$$1" ]; then \
			echo "Enter the title of the new note:"; \
			read TITLE; \
		else \
			TITLE=$$1; \
		fi; \
	fi; \
	mkdir -p $(NOTES_DIR); \
	chmod 755 $(NOTES_DIR); \
	LAST_NOTE=$$(ls $(NOTES_DIR) 2>/dev/null | sort | tail -n 1); \
	if [ -z "$$LAST_NOTE" ]; then \
		LAST_SEQ_NUM="a000"; \
	else \
		LAST_SEQ_NUM=$$(echo $$LAST_NOTE | cut -d'_' -f1); \
	fi; \
	LAST_LETTER=$$(echo $$LAST_SEQ_NUM | cut -c1); \
	LAST_NUMBER=$$(echo $$LAST_SEQ_NUM | cut -c2- | sed 's/^0*//'); \
	NEXT_NUMBER=$$((LAST_NUMBER + 1)); \
	if [ $$NEXT_NUMBER -gt 999 ]; then \
		NEXT_NUMBER=1; \
		NEXT_LETTER=$$(echo "$$LAST_LETTER" | tr "a-y" "b-z"); \
	else \
		NEXT_LETTER=$$LAST_LETTER; \
	fi; \
	PADDED_NUM=$$(printf "%s%03d" $$NEXT_LETTER $$NEXT_NUMBER); \
	DATE=$$(date +'%Y-%m-%d'); \
	FILENAME="$(NOTES_DIR)/$${PADDED_NUM}_$$(echo $${TITLE} | tr '[:upper:]' '[:lower:]' | sed 's/ /_/g')-$${DATE}.md"; \
	echo "# $${TITLE}" > "$$FILENAME"; \
	echo >> "$$FILENAME"; \
	echo "### Metadata" >> "$$FILENAME"; \
	echo "Date: $${DATE}" >> "$$FILENAME"; \
	echo "Author: Your Name" >> "$$FILENAME"; \
	echo "Category: General" >> "$$FILENAME"; \
	echo >> "$$FILENAME"; \
	echo "### Summary" >> "$$FILENAME"; \
	echo "A brief summary of the note." >> "$$FILENAME"; \
	echo >> "$$FILENAME"; \
	echo "### Content" >> "$$FILENAME"; \
	echo "Write your main content here." >> "$$FILENAME"; \
	echo >> "$$FILENAME"; \
	echo "### Additional Notes" >> "$$FILENAME"; \
	echo "Any additional notes or references." >> "$$FILENAME"; \
	echo >> "$$FILENAME"; \
	chmod 644 "$$FILENAME"; \
	echo "Note '$$TITLE' created at '$$FILENAME'"

# List all notes grouped by prefix with optional keyword search
list:
	@SEARCH_KEYWORD="$(SEARCH)"; \
	echo "Listing all notes in $(NOTES_DIR) grouped by prefix:"; \
	for prefix in a b c d e f g h i j k l m n o p q r s t u v w x y z; do \
		if [ -n "$$SEARCH_KEYWORD" ]; then \
			match_notes=$$(ls $(NOTES_DIR)/$$prefix*$$SEARCH_KEYWORD*.md 2>/dev/null | head -n 5); \
		else \
			match_notes=$$(ls $(NOTES_DIR)/$$prefix*.md 2>/dev/null | head -n 5); \
		fi; \
		if [ -n "$$match_notes" ]; then \
			echo "Group '$$prefix':"; \
			for note in $$match_notes; do \
				echo "  - $$(basename $$note)"; \
			done; \
		fi; \
	done

# Open a note in the default text editor
edit:
	@bash -c ' \
	echo "Enter the name of the note to edit:"; \
	read NOTE_NAME; \
	EDITOR=$${EDITOR:-vim}; \
	FILE="$(NOTES_DIR)/$${NOTE_NAME}"; \
	if [ -f "$$FILE" ]; then \
		$$EDITOR "$$FILE"; \
	else \
		echo "Note '"'"'$$NOTE_NAME'"'"' not found."; \
	fi'

# Clean up notes with confirmation
clean:
	@echo "Are you sure you want to delete all notes? [y/N]"; \
	read CONFIRMATION; \
	if [ "$$CONFIRMATION" = "y" ] || [ "$$CONFIRMATION" = "Y" ]; then \
		rm -f $(NOTES_DIR)/*.md; \
		echo "All notes have been removed."; \
	else \
		echo "Operation cancelled. No notes were removed."; \
	fi

# Disable the default behavior of treating targets as files
%:
	@:

# Display help as default target
.DEFAULT_GOAL := help