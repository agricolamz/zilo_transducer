# Morphological transducer for Zilo Andi

This is a repository for a morphological parser for Zilo Andi.

## Background

Andi belongs to the Andic group within the Avar-Andic branch of the Nakh-Daghestanian family. Aglarov (2002: 3) estimates the Andi ethnic population at 40,000, including 17,000 in the historical Andi area situated in the Botlikhsky District of Dagestan and 23,000 outside it, predominantly in the Khasavyurtovsky, Babayurtovsky and Kizilyurtovsky districts of the same republic. A total of 5,800 Andi speakers is recorded in the 2010 Russian census, while the 2002 Russian census recorded 23,729 Andi speakers, which is more consistent with Aglarov’s estimate. Each settlement possesses its own distinct variety of the language. However, following Cercvadze (1965: 312), two broad dialect groups can be recognized: Upper Andi, spoken in the villages of Andi, Ashali, Chanko, Gagatli, Gunkha, Rikvani and Zilo, and Lower Andi, spoken in Muni and Kvankhidatli. This morphological parser is based on the Upper Andi variety of Zilo (endonym ziludirab mic’ːi) described in

```
Kaye, S., Moroz, G., Rochant, N., Verhees, S., and Zakirova, A. (Forthc.). Andi (Zilo dialect). In Lander, Y., Maisak, T., and Koryakov, Y., editors, The Caucasian Languages. An International Handbook. De Gruyter Mouton, Berlin/New York.
```

Dictionary data was collected in the field by George Moroz.

## Usage

In order to use it you need to install [`lexd`](https://github.com/apertium/lexd) and [`hfst`](https://github.com/hfst/hfst):

```
curl -sS https://apertium.projectjj.com/apt/install-nightly.sh | sudo bash
apt install lexd
apt install hfst
```

After it you can clone the repository and compile it:

```
git clone git@github.com:agricolamz/zilo_transducer.git
cd zilo_trasducer
make
```

If everything is fine you can 

- analyze some form

```
$ echo "боъоцIоллой" | hfst-lookup ani_analizer.hfst 
hfst-lookup: warning: It is not possible to perform fast lookups with OpenFST, std arc, tropical semiring format automata.
Using HFST basic transducer format and performing slow lookups
> боъоцIоллой	<an><sg>оъо<num><crown><linker>	0.000000
боъоцIоллой	<inan1>оъо<num><crown><linker>	0.000000
```

- generate some form

```
$ echo "чIе<num><crown><card>" | hfst-lookup ani_generator.hfst 
hfst-lookup: warning: It is not possible to perform fast lookups with OpenFST, std arc, tropical semiring format automata.
Using HFST basic transducer format and performing slow lookups
> чIе<num><crown><card>	чIецIолгу	0.000000
```

- see all possible forms and analyses:

```
$ hfst-fst2strings ani_analizer.hfst
```

## How to cite this parser

If you want to cite this work use the following format:

```
Moroz, G. (2022) Morphological parser for Zilo Andi. (Version 0.0.1)
```

## Number of forms generated: 

11821
