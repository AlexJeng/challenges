require 'editor'
require 'expected_images'

describe GraphicalEditor::Editor do
  let(:editor) { described_class.new }

  describe 'executing a cmd' do
    context "when 'X' cmd received" do
      it 'terminates the session' do
        expect { editor.execute('X') }.to raise_error SystemExit
      end
    end

    context "when 'I M N' cmd received" do
      it 'creates a new M x N image with all pixels coloured white (O)' do
        GraphicalEditor::Image.should_receive(:new).with(5, 6)
        editor.execute('I 5 6')
      end
      it 'shows the new image with all pixels coloured white (O)' do
        editor.execute('I 5 6')
        output = capture_stdout {editor.execute('S')}
        output.should eq IMAGE_CLEAN
      end
    end

    context "when 'L X Y C' cmd received" do
      it 'colours the pixel (X,Y) with colour C' do
        editor.execute('I 5 6')
        editor.execute('L 2 3 A')
        output = capture_stdout {editor.execute('S')}
        output.should eq IMAGE_WITH_L_2_3_A
      end
    end

    context "when 'C' cmd received" do
      it 'clears image to default color' do
        editor.execute('I 5 6')
        editor.execute('L 2 3 A')
        editor.execute('C')
        output = capture_stdout {editor.execute('S')}
        output.should eq IMAGE_CLEAN
      end
    end

    context "when 'V X Y1 Y2 C' cmd received" do
      it 'draws a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive)' do
        editor.execute('I 5 6')
        editor.execute('V 2 3 4 W')
        output = capture_stdout {editor.execute('S')}
        output.should eq IMAGE_WITH_V_2_3_4_W
      end
    end

    context "when 'H X1 X2 Y C' cmd received" do
      it 'draws a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive)' do
        editor.execute('I 5 6')
        editor.execute('H 3 4 2 Z')
        output = capture_stdout {editor.execute('S')}
        output.should eq IMAGE_WITH_H_3_4_2_Z
      end
    end

    context "when 'F X Y C' cmd received" do
      it 'fills the region R with the colour C' do
        editor.execute('I 5 6')
        editor.execute('H 3 4 2 Z')
        editor.execute('F 3 3 J')
        output = capture_stdout {editor.execute('S')}
        output.should eq IMAGE_WITH_H_3_4_2_Z_F_3_3_J
      end
    end
  end

  # WORKAROUND: Test output to command line with RSpec
  # http://stackoverflow.com/q/11349270/462015
  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end
end
