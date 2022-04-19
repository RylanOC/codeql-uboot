import cpp

class NetworkByteSwap extends Expr {
  NetworkByteSwap () {
    exists(MacroInvocation inv |
      inv.getMacroName() in ["ntohs", "ntohl", "ntoll"] and
      this = inv.getExpr()
    )
  }
}

from NetworkByteSwap n
select n, "Network byte swap"