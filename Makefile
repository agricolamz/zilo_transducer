.DEFAULT_GOAL := ani_analizer.hfst

ani_analizer.hfst: ani_generator.hfst
	hfst-invert $< -o $@
ani_generator.hfst: ani_lexd.hfst ani_twol.hfst
	hfst-compose-intersect $^ -o $@
ani_lexd.hfst: ani.lexd
	lexd $< | hfst-txt2fst -o $@
ani_twol.hfst: ani.twol
	hfst-twolc $< -o $@
ani.lexd: $(wildcard ani_*.lexd)
	cat ani_*.lexd > ani.lexd
test.pass.txt: ani_tests.csv
	awk -F, '$$3 == "pass" {print $$1 ":" $$2}' $^ | sort -u > $@
test: ani_generator.hfst test.pass.txt
	bash compare.sh $< test.pass.txt; rm test.*
clean:
	rm *.hfst
forms_count:
	hfst-fst2strings ani_analizer.hfst | wc -l
forms_count_write: ani_analizer.hfst
	sed -i "$(cat README.md | wc -l)s/^.*$/$(hfst-fst2strings ani_analizer.hfst | wc -l)/" README.md
