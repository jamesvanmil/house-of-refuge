class AdmissionFacetHashBuilder
  attr_reader :facet_hash

  def initialize(relation:, facet_array:)
    @facet_hash = build_facets(unlimit(relation), facet_array)
  end

  private

  def build_facets(relation, facet_array)
    facets = Hash.new
    facet_array.each do |field|
      facets[field] = Hash[ relation.uniq.pluck(field).zip([nil]) ]
      facets[field].keys.each do |value|
        facets[field][value] = relation.where("#{field.to_s} = ? ", value).count
      end
    end
    facets
  end

  def unlimit(relation)
    relation.paginate(page: 1, per_page: relation.count)   
  end
end
