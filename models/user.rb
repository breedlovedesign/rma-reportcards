# encoding: utf-8
class User
	include Mongoid::Document
	field :id,         type: String
	field :uid,        type: String
	field :name,       type: String
	field :nickname,   type: String
	field :created_at, type: DateTime
end