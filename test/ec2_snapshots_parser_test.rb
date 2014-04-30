require 'test/unit'
require_relative '../bin/delete-old-ebs-snapshots'

class Ec2SnapshotsParserTest < Test::Unit::TestCase
  def subject(&block)
    s = Ec2SnapshotsParser.new(IO.readlines('./test/fixtures/sample-data.txt'))
    block.call(s)
  end

  def test_reads_all_rows
    expected = 54
    subject { |s| assert(s.snapshots.length == expected, "Expected #{expected} snapshots, actually #{s.snapshots.length} snapshots") }
  end

end
