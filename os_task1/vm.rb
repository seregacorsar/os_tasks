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
	p = $table_kom[arg][1]
  zapp = p == 0 ? 1 : 0
  zam1 = p == 1 ? 1 : 0
  vzap1 = p == 3 ? 1 : 0
  zam2 = p != 3 ? 1 : 0
  chist = (p == 2 or p == 3) ? 1 : 0
  pusk = arg != 'ff' ? 1 : 0
  vyb = $table_kom[arg][0]
end


def alu(arg0, arg1):
	op = $com_table[$kop][2]
  return arg0 if op == 0
	return arg1 if op == 1
	return arg0 + arg1 if op == 2
	return arg1 - arg0 if op == 3
	return $ron if op == 15
	return -1
end


instr = File.open("image") { |f| f.read }
puts instr

prog = instr.split
# puts instructions.size
i = 0
j = 0
while i < prog.size
  kop = prog[i].hex.to_i
  adr = prog[i+1].hex.to_i
  i+=2
  # puts "#{kop}, #{adr}"
  commands[j++] = [kop, adr]
end

ip = 0
while true
  $kop = commands[ip][0]
  $adr = commands[ip][1]
  dekkom $kop
  
end