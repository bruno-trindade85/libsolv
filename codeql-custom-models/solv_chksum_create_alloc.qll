// codeql-custom-models/solv_chksum_create_alloc.qll
import cpp
import semmle.code.cpp.models.implementations.Allocation // Importa a biblioteca para modelar alocações

/**
 * Define 'solv_chksum_create' como uma função que aloca memória.
 *
 * @kind predicate
 */
class SolvChksumCreateAlloc extends AllocationFunction {
  SolvChksumCreateAlloc() {
    // Identifica a função pelo seu nome.
    // Pode-se adicionar mais predicados aqui para ser mais específico (ex: tipos de parâmetros),
    // mas o nome geralmente é suficiente para funções customizadas.
    this.getName() = "solv_chksum_create"
    and this instanceof Function // Garante que estamos nos referindo à função e não a algo mais
  }

  // Especifica que o valor de retorno da função aloca memória.
  // O LLM identificou 's' como alocado, e 's' é o valor de retorno da função.
  override predicate allocates(Expr e) {
    e = this.getAnInvocation().getResult() // 'e' é o resultado de uma invocação desta função
  }

  // Se a memória fosse dealocada por esta função, você adicionaria um override para 'deallocates'.
  // Como o LLM não listou 'solv_chksum_create' em 'deallocated_variables' (apenas 's' se fosse interna),
  // e o bug é um *vazamento*, não estamos declarando uma dealocação aqui.
}