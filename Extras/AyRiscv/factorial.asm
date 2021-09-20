.globl start

.text
	start:

    li a0, 3  # numero a calcular su factorial
    jal ra, fact  # llamamos a factorial(n=3) y guardamos la direccion actual direccion en ra

    li a7, 1
    ecall
    li a7, 10
    ecall

    fact:
        blt zero, a0, rec  # revisamos si es el caso base n = 0
        li a0, 1 # cargamos 1 en a0
        jalr zero, 0(ra) # llamamos a la funcion que recupera del stack

    rec:
        sw ra, -4(sp)  # guardamos la direccion de retorno al stack (lo que habia del ultimo jal/r)
        sw a0, -8(sp)  # guardamos el valor de a0 en el stack
        addi sp, sp, -8  # desplazamos el stack

        addi a0, a0, -1 # n - 1
        jal ra, fact  # llamamos a factorial(n-1) y guardamos esta direccion en ra

    addi sp, sp, 8 # retrocedemos en el stack
    lw ra, -4(sp) # recuperamos ra
    lw t0, -8(sp) # recuperamos el valor de n para esa llamada
    mul a0, t0, a0 # n * factorial(n-1)
    jalr zero, 0(ra) # volvemos a a la direccion anterior hasta llegar al valor original