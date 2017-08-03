require 'elasticsearch/model'

class Document < ApplicationRecord
  ac_field :name
	include Elasticsearch::Model
  	include Elasticsearch::Model::Callbacks
    index_name [Rails.env, model_name.collection].join("_")

	belongs_to :user

  Document.import force: true
  # Document.__elasticsearch__.create_index! force: true 
  # Document.__elasticsearch__.client.indices.delete index: Document.index_name rescue nil
    
    def self.search(query)
      __elasticsearch__.search(
        {
          query: {
            function_score: {
              query: {
                multi_match: {
                  query: query,
                  fields: ['name', 'service'],
                  fuzziness: "AUTO"
                }
              },
              field_value_factor: {
                field: 'clicks',                  
                modifier: 'square',
                factor: 3
              }
              # highlight: {
              #   pre_tags: ['<em>'],
              #   post_tags: ['</em>'],
              #   fields: {
              #     name: {},
              #     service: {}
              #   }
              # }
            }
          }
        }
      )
    end

  settings index: { "number_of_shards": 1, 
      analysis: {
        analyzer: {
          # string_lowercase: { tokenizer: 'keyword', filter: %w(lowercase ascii_folding) },
          # did_you_mean: { filter: ['lowercase'], char_filter: ['html_strip'], type: 'custom', tokenzier: 'standard'},
          # autocomplete: {filter: ["lowercase", "autocompleteFilter"], char_filter: [ "html_strip"], type: "custom", tokenizer: "standard"},
          # default: {filter: [ "lowercase", "stopwords", "stemmer"], char_filter: [ "html_strip"], type: "custom",tokenizer: "standard"},
          edge_ngram_analyzer: { type: "custom", tokenizer: "standard", filter: ["lowercase", "edge_ngram_filter", "stop", "kstem" ] },
            }
        },
        filter: { ascii_folding: { type: 'asciifolding', preserve_original: true }, 
                  # stemmer: {type: 'stemmer', language: 'english'},
                  # autocompleteFilter: { max_shingle_size: 5, min_shingle_size:2, type: 'shingle'},
                  # stopwords: {type: 'stop', stopwords: ['_english_']},
                  edge_ngram_filter: { type: "edgeNGram", min_gram: "3", max_gram: "20" } 
      }
    } do
      mapping do
        indexes :name, type: "string", analyzer: "edge_ngram_analyzer", term_vector: "with_positions"
        indexes :service, type: "string", analyzer: "edge_ngram_analyzer", term_vector: "with_positions"
      end 
  end

end
