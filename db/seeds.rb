# coding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

categories = Category.create([
  {:name => "Indústria, Comércio e Emprego"},
  {:name => "Ciência e Tecnologia"},
  {:name => "Direitos Humanos"},
  {:name => "Educação"},
  {:name => "Esportes, Lazer e Cultura"},
  {:name => "Orçamento e Fiscalização Financeira"},
  {:name => "Saúde e Drogas"},
  {:name => "Crianças e adolescentes"},
  {:name => "Pessoas de terceira idade"},
  {:name => "Meio Ambiente e Direitos dos Animais"},
  {:name => "Defesa do Consumidor"},
  {:name => "Obras Públicas e Infraestrutura"},
  {:name => "Transportes e Trânsito"},
  {:name => "Turismo"},
  {:name => "Ordem Pública"},
  {:name => "Habitação"}
])
