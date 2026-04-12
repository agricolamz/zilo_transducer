.PHONY: all

all: ani_analyzer.hfstol ani_generator.hfstol ani_analyzer_stem_translation.hfstol

substring_search: ani_generator.hfst
	@echo "$(REGEX)" | hfst-regexp2fst | hfst-compose-intersect ani_generator.hfst | hfst-fst2strings

ani_%.hfstol: ani_%.hfst
	hfst-fst2fst -O $< -o $@

ani_analyzer_stem_translation.hfst: ani_analyzer.hfst
	lexd ani_rus.lexd | hfst-txt2fst | hfst-repeat -f 1 | hfst-compose -1 ani_analyzer.hfst -o $@

ani_analyzer.hfst: ani_generator.hfst remove_hyphen.hfst
	hfst-compose-intersect $^ | hfst-invert -o $@

remove_hyphen.hfst: remove_hyphen.twol
	hfst-twolc -q $< -o $@

ani_rus.lexd: ani_generator.hfst
	Rscript scripts/generate_ani_rus_correspondences.R

ani_generator.hfst: ani_personal_pronouns.hfst ani_demonstratives.hfst
	hfst-union $^ -o $@

ani_%.hfst: ani_%.lexd
	lexd $< | hfst-txt2fst -o $@

dictionary.csv:
	curl https://raw.githubusercontent.com/LingConLab/zilo_dictionary/refs/heads/main/data/data.csv -o data/dictionary.csv

clean:
	rm *.hfst *.hfstol
