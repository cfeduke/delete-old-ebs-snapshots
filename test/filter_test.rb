require 'test/unit'
require 'date'
require_relative '../bin/delete-old-ebs-snapshots'

class FilterTest < Test::Unit::TestCase

  def subject(&block)
    data = <<-DATA
SNAPSHOT\tsnap-0bfd0417\tvol-5c4e732b\tcompleted\t2013-12-17T21:55:25+0000\t100%\t296106742331\t10\text4 formatted 10GB logging drive
SNAPSHOT\tsnap-0e339c1c\tvol-9db1ced0\tcompleted\t2014-01-09T04:20:16+0000\t100%\t296106742331\t25\tCreated by CreateImage(i-5057cf70) for ami-31043258 from vol-9db1ced0
SNAPSHOT\tsnap-113c1916\tvol-9c7f73d6\tcompleted\t2013-11-04T22:36:33+0000\t100%\t296106742331\t15\tCreated by CreateImage(i-c8f92db5) for ami-1d8bd374 from vol-9c7f73d6
SNAPSHOT\tsnap-11ef100d\tvol-5c4e732b\tcompleted\t2013-12-17T20:14:10+0000\t100%\t296106742331\t10\tCreated by CreateImage(i-a0a4f1dc) for ami-1b4f6672 from vol-5c4e732b
SNAPSHOT\tsnap-16ef100a\tvol-4db2803a\tcompleted\t2013-12-17T20:14:10+0000\t100%\t296106742331\t25\tCreated by CreateImage(i-a0a4f1dc) for ami-1b4f6672 from vol-4db2803a
    DATA
    snapshots = Ec2SnapshotsParser.new(data.split("\n")).snapshots
    block.call(Filter.new(snapshots))
  end

  def test_apply_filters_dates
    predicate = Proc.new { |d| d <= DateTime.parse("2013-12-17") }
    subject { |s| assert(s.apply(:start_time => predicate).length == 1) }
  end

  def test_apply_filters_description
    predicate = Proc.new { |desc| desc =~ Regexp.new("CreateImage") }
    subject { |s| assert(s.apply(:description => predicate).length == 4) }
  end

  def test_apply_filters_both
    one = Proc.new { |d| d <= DateTime.parse("2014-12-31") }
    two = Proc.new { |desc| desc =~ Regexp.new("ami-1") }
    subject do |s|
      assert(s.apply(:start_time => one, :description => two).length == 3)
    end
  end

end
