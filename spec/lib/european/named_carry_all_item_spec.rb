require 'spec_helper'

module European

  describe NamedCarryAllItem do

    describe '#new' do

      let :new_without_name do
        lambda {
          NamedCarryAllItem.new({})
        }
      end

      let :new_with_name_and_proc do
        lambda {
          proc = Proc.new {
            @some_value = 1
            def some_value
              @some_value
            end
          }
          NamedCarryAllItem.new({ name: 'RandomItem', proc: proc })
        }
      end

      it 'requires args with a :name' do
        expect(new_without_name).to raise_error ':name is required'
      end

      it 'can optionally process args with a :proc' do
        expect(new_with_name_and_proc).to_not raise_error
      end

      it 'does not immediately instance eval the proc' do
        proc = Proc.new {
          @some_value = 1
          def some_value
            @some_value
          end
        }
        ncai = NamedCarryAllItem.new({ name: 'RandomItem', proc: proc })
        expect(ncai).to_not respond_to :some_value
      end

    end

    describe '#setup' do

      it 'instance evals the associated proc' do
        proc = Proc.new {
          @some_value = 1
          def some_value
            @some_value
          end
        }
        ncai = NamedCarryAllItem.new({ name: 'RandomItem', proc: proc })
        ncai.setup
        expect(ncai.some_value).to eq 1
      end

      it 'does not blow up if there is no associated proc' do
        expect(lambda {
                 ncai = NamedCarryAllItem.new({ name: 'RandomItem' })
                 ncai.setup
               }).to_not raise_error
      end

    end

  end

end
