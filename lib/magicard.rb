# frozen_string_literal: true

require 'magicard/version'
require 'magicard/cli'
require 'magicard/loader'

require 'magicard/mtg_api/cards_get'

require 'magicard/getter/acts_as_getter'
require 'magicard/getter/type1'
require 'magicard/getter/type2'
require 'magicard/getter/type3'

module Magicard
  class Error < StandardError; end
end
