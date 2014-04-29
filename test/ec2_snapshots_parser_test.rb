require 'test/unit'
require_relative '../bin/delete-old-ebs-snapshots'

class Ec2SnapshotsParserTest < Test::Unit::TestCase
  def subject(&block)
    s = Ec2SnapshotsParser.new(IO.read('./test/fixtures/sample-data.txt'))
    block.call(s)
  end

  def test_reads_all_rows
    expected = 54
    subject { |s| assert(s.rows.length == expected, "Expected #{expected} rows, actually #{s.rows.length} rows") }
  end

end
