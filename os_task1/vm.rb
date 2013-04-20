$p, $zapp, $zam1, $zam2, $vzap1, $vib, $chist, $op, $ron, $rvv, $IR, $IP, $IA =
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

$table_kom = {
  '00' => [1, 0, 0, 0],
  '11' => [0, 1, 1, 0],
  '15' => [1, 1 ,1 ,0],
	'02' => [0, 2, 0, 0],
	'21' => [0, 1, 2, 0],
	'25' => [1, 1, 2, 0],
	'31' => [0, 1, 3, 0],
	'fe' => [-1, 4, 15, 1],
	'f0' => [-1, 4, 15, 0],
	'f1' => [1, 4, 15, 0],
	'f4' => [1, 4, 15, 1],
	'f5' => [1, 4, 15, 0],
	'ff' => [1, 4, 15, 0]
}
# puts table_kom['21'][3]

def dekkom(arg)
#puts "arg = #{arg.to_s(16)}"
	$p = $table_kom[arg.to_s(16)][1]
#puts "p = #{$p}"
  $zapp = $p == 0 ? 1 : 0
  $zam1 = $p == 1 ? 1 : 0
  $vzap1 = $p == 3 ? 1 : 0
  $zam2 = $p != 3 ? 1 : 0
  $chist = ($p == 2 or $p == 3) ? 1 : 0
  $pusk = arg != 'ff' ? 1 : 0
  $vib = $table_kom[arg.to_s(16)][0]
end


def alu(arg0, arg1)
#puts "kop = #{$kop.to_s(16)}"
	$op = $table_kom[$kop.to_s(16)][2]
#puts "op = #{$op}"
  return arg0 if $op == 0
	return arg1 if $op == 1
	return arg0 + arg1 if $op == 2
	return arg1 - arg0 if $op == 3
	return $ron if $op == 15
	return -1
end

def m(*args)
	return args[args[-1]]
end


instr = File.open("image") { |f| f.read }
#puts instr

#puts m(12, 14, 0)
prog = instr.split
# puts prog.size
i = 0
j = 0
cmds = [Array.new, Array.new]
while i < prog.size
  kop = prog[i].hex.to_i
  adr = prog[i+1].hex.to_i
  i+=2
#puts "#{kop}, #{adr}"
  cmds[j] = [kop, adr]
  j+=1
end
#$IP = 0
#$IR = 0
$pusk = 1
#while true
  $kop = cmds[$IP][0]
#puts "kop = #{$kop}"
  $adr = cmds[$IP][1]
  dekkom $kop
  $IA = tmp1 = $adr + $IR
  tmp0 = cmds[tmp1][1]
  tmp2 = $rvv
  tmp1 = m(tmp0, tmp1, tmp2, $vib)
  tmp0 = $ron
  tmp0 = alu(tmp0, tmp1)
  
  tmp = m(tmp0, 0, $chist)
  $IR = tmp if $zam2 == 1
  
  $ron = tmp0 if $zam1 == 1
  
  cmds[$IP + $IA][1] = tmp0
  
  tmp = m($IP + 1, $IA, $table_kom[$kop.to_s(16)][3])
  if $pusk == 1
    $IP = tmp
  else
    break
  end
  
#puts "end"
#end