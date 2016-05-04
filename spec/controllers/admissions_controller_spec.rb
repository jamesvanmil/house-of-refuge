require 'rails_helper'

RSpec.describe AdmissionsController, type: :controller do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AdmissionsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #show" do
    it "assigns the requested admission as @admission" do
      admission = Admission.create!
      get :show, {id: admission.to_param}, valid_session
      expect(assigns(:admission)).to eq(admission)
    end
  end

  describe "GET #index" do
    before :all do

      # functions for test objects
      admission_date = proc do
        year  = rand(1869..1909).to_s
        month = "%02d" % (rand(1..12).to_s)
        day   = "%02d" % (rand(1..28).to_s)
        (year + month + day).to_i
      end
      age = proc { rand(0..21) }
      for_what_committed_index = proc { ["Homeless or unsuitable home", "Larceny", "Incorrigibility", nil].sample }
      full_name = proc { "#{Faker::Name.last_name}, #{Faker::Name.first_name}" }
      gender = proc { ['female', 'male', 'unknown'].sample }
      parentage_index = proc { ['American', 'German', 'Negro', nil].sample }

      100.times do
        FactoryGirl.create(:admission,
          admission_date: admission_date.call,
          age: age.call,
          full_name: full_name.call,
          gender: gender.call,
          parentage_index: parentage_index.call
        )
      end
    end

    after :all do
      Admission.destroy_all
    end

    let(:limit) { 10 }
    let(:page) { search.limit(limit).collect { |a| a.id } }
    let(:result) { assigns(:admissions).collect { |a| a.id } }

    context "with no params set" do
      let(:search) { Admission.all }

      it "assigns first page of matching admissions as @admissions" do
        get :index, {  }, valid_session
        expect(result).to eq page
      end
    end

    context "with facets set" do
      let(:parentage_one_value) { [Admission.uniq.pluck(:parentage_index).sample] }
      let(:parentage_two_values) { Admission.uniq.pluck(:parentage_index).sample(2) }

      context "with one facet" do
        context "with one value" do
          let(:search) { Admission.where(parentage_index: parentage_one_value) }

          it "assigns first page of matching admissions as @admissions" do
            get :index, { parentage_index: parentage_one_value }, valid_session
            expect(result).to eq page
          end
        end

        context "with more than value" do
          let(:search) { Admission.where(parentage_index: parentage_two_values) }

          it "assigns first page of matching admissions as @admissions" do
            get :index, { parentage_index: parentage_two_values }, valid_session
            expect(result).to eq page
          end
        end
      end

      context "with more than facet" do
        let(:age_three_values) { Admission.where(parentage_index: parentage_two_values).uniq.pluck(:age).sample(3) }
        let(:search) { Admission.where(parentage_index: parentage_two_values, age: age_three_values) }

        it "assigns first page of matching admissions as @admissions" do
          get :index, { parentage_index: parentage_two_values, age: age_three_values }, valid_session
          expect(result).to eq page
        end
      end
    end

    context "with dates set" do
      let(:sorted_dates) { Admission.uniq.pluck(:admission_date).compact.sort }
      let(:start_date_i) { sorted_dates[30] }
      let(:end_date_i) { sorted_dates[-30] }

      let(:start_date) do
        year, month, day = start_date_i.to_s.match(%r{(\d{4})(\d{2})(\d{2})}).captures
        "#{month}/#{day}/#{year}"
      end

      let(:end_date) do
        year, month, day = end_date_i.to_s.match(%r{(\d{4})(\d{2})(\d{2})}).captures
        "#{month}/#{day}/#{year}"
      end

      context "(start date only)" do
        let(:search) { Admission.where(admission_date: start_date_i..99999999) }

        it "assigns first page of matching admissions as @admissions" do
          get :index, { begin_date: start_date }, valid_session
          expect(result).to eq page
        end
      end

      context "(end date only)" do
        let(:search) { Admission.where(admission_date: 0..end_date_i) }

        it "assigns first page of matching admissions as @admissions" do
          get :index, { end_date: end_date }, valid_session
          expect(result).to eq page
        end
      end

      context "(both dates)" do
        let(:search) { Admission.where(admission_date: (start_date_i - 1)..end_date_i) }

        it "assigns first page of matching admissions as @admissions" do
          get :index, { begin_date: start_date, end_date: end_date }, valid_session
          expect(result).to eq page
        end
      end
    end

    context "with gender set" do
      context "to one value" do
        let(:search) { Admission.where(gender: 'female') }

        it "assigns first page of matching admissions as @admissions" do
          get :index, { female: "1" }, valid_session
          expect(result).to eq page
        end
      end

      context "to more than one value" do
        let(:search) { Admission.where(gender: ['female', 'male']) }

        it "assigns first page of matching admissions as @admissions" do
          get :index, { female: "1", male: "1" }, valid_session
          expect(result).to eq page
        end
      end
    end

    context "with name set" do
      let(:name) { Admission.first.full_name }
      let(:search) { Admission.where("full_name ILIKE ?", "%#{name}%") }

      it "assigns first page of matching admission as @admissions" do
        get :index, { name: name }, valid_session
        expect(result).to eq page
      end
    end

    context "with page set" do
      let(:search) { Admission.offset(limit) }

      it "assigns correct page of matching admission as @admissions" do
        get :index, { page: 2 }, valid_session
        expect(result).to eq page
      end
    end

    describe "@facet_hash" do
      let(:search) { Admission.all }
      let(:count) { search.count }
      let(:result) { assigns(:facet_hash) }
      let(:facet_name) { :age }
      let(:facet_hash) { result[facet_name] }
      let(:facet_values) { facet_hash.values }
      let(:facet_values_sum) { facet_values.inject(:+) }
      let(:search_field_counts) do
        facet_hash.keys.collect do |key|
          search.where(["#{facet_name} = ?", key]).count
        end
      end

      it "has data for all search objects, not just current page" do
        get :index, { }, valid_session
        expect(facet_values_sum).to eq count
      end

      it "is a hash of hashes" do
        get :index, { }, valid_session
        expect(result).to be_a(Hash)
        expect(facet_hash).to be_a(Hash)
      end

      it "has facet field names as keys" do
        get :index, { }, valid_session
        expect(result.keys).to match_array(subject.send(:facet_fields))
      end

      describe "nested values" do
        it "have field values as keys" do
          get :index, { }, valid_session
          expect(facet_hash.keys).to match_array(search.uniq.pluck(facet_name))
        end

        it "have field value counts as values" do
          get :index, { }, valid_session
          expect(facet_values).to match_array(search_field_counts)
        end
      end
    end
  end
end
