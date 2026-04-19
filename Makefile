.PHONY: all

all: ani_analyzer.hfstol ani_generator.hfstol ani_analyzer_stem_translation.hfstol

substring_search: ani_generator.hfst
	@echo "$(REGEX)" | hfst-regexp2fst | hfst-compose-intersect ani_generator.hfst | hfst-fst2strings

ani_%.hfstol: ani_%.hfst
	hfst-fst2fst -O $< -o $@

ani_analyzer_stem_translation.hfst: ani_rus.lexd ani_analyzer.hfst
	lexd $< | hfst-txt2fst | hfst-repeat -f 1 | hfst-compose -1 ani_analyzer.hfst -o $@

ani_analyzer.hfst: ani_generator.hfst remove_hyphen.hfst
	hfst-compose-intersect $^ | hfst-invert -o $@

remove_hyphen.hfst: remove_hyphen.twol
	hfst-twolc -q $< -o $@

update_dictionary_data: ani_generator.hfst dictionary.csv
	Rscript scripts/generate_ani_rus_correspondences.R
	Rscript scripts/generate_ani_rus_adjectives_lexicon.R

dictionary.csv:
	curl https://raw.githubusercontent.com/LingConLab/zilo_dictionary/refs/heads/main/data/data.csv -o data/dictionary.csv

ani_generator.hfst: ani_personal_pronouns.hfst ani_demonstratives.hfst ani_numerals.hfst ani_adjectives_merged.hfst
	hfst-union ani_personal_pronouns.hfst ani_demonstratives.hfst | hfst-union ani_numerals.hfst | hfst-union ani_adjectives_merged.hfst -o $@

ani_%_merged.hfst: ani_%.hfst ani_%_twol.hfst
	hfst-compose-intersect $^ -o $@

ani_%_twol.hfst: ani_%.twol
	hfst-twolc -q $< -o $@

ani_%.hfst: ani_%.lexd
	lexd $< | hfst-txt2fst -o $@

ani_%.lexd: ani_%_formation.lexd ani_%_lexicon.lexd
	cat $^ > $@

clean:
	rm -f *.hfst *.hfstol
