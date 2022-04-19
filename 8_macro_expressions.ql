import cpp

from MacroInvocation inv
where inv.getMacroName() in ["ntohs", "ntohl", "ntoll"]
select inv.getExpr()
