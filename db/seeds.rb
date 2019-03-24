# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


Instrument.create(ins_name_ja: "ピアノ", ins_name_en: "Piano")
Instrument.create(ins_name_ja: "ギター", ins_name_en: "Guitar")
Instrument.create(ins_name_ja: "ベース", ins_name_en: "Bass")
Instrument.create(ins_name_ja: "ドラム", ins_name_en: "Drums")
Instrument.create(ins_name_ja: "ボーカル", ins_name_en: "Vocal")
Instrument.create(ins_name_ja: "サックス", ins_name_en: "Saxophone")
Instrument.create(ins_name_ja: "トランペット", ins_name_en: "Trumpet")
Instrument.create(ins_name_ja: "トロンボーン", ins_name_en: "Trombone")
Instrument.create(ins_name_ja: "クラリネット", ins_name_en: "Clarinet")
Instrument.create(ins_name_ja: "フルート", ins_name_en: "Flute")
Instrument.create(ins_name_ja: "その他", ins_name_en: "Others")

Subject.create(subj_name_ja: "楽器の基礎技術", subj_name_en: "Basic instrument skill")
Subject.create(subj_name_ja: "リズム", subj_name_en: "Rythm")
Subject.create(subj_name_ja: "タイム", subj_name_en: "Time feeling")
Subject.create(subj_name_ja: "コンピング", subj_name_en: "Comping")
Subject.create(subj_name_ja: "コードボイシング", subj_name_en: "Chord Voicing")
Subject.create(subj_name_ja: "作曲", subj_name_en: "Composition")
Subject.create(subj_name_ja: "インプロヴィゼーション", subj_name_en: "Improvisation")
Subject.create(subj_name_ja: "スケール", subj_name_en: "Scale")
Subject.create(subj_name_ja: "リック", subj_name_en: "Lick")
Subject.create(subj_name_ja: "リハーモナイゼ ーション", subj_name_en: "Reharmonization")
Subject.create(subj_name_ja: "モチーフデベロップメント", subj_name_en: "Reharmonization")
Subject.create(subj_name_ja: "発声", subj_name_en: "Reharmonization")
Subject.create(subj_name_ja: "歴史", subj_name_en: "History")

Language.create(lang_name: "日本語")
Language.create(lang_name: "English")
Language.create(lang_name: "中文")
Language.create(lang_name: "Español")
