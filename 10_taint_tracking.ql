/**
 * @kind path-problem
 */

import cpp
import semmle.code.cpp.dataflow.TaintTracking
import DataFlow::PathGraph

class NetworkByteSwap extends Expr {
    NetworkByteSwap () {
        exists(MacroInvocation inv |
          inv.getMacroName() in ["ntohs", "ntohl", "ntoll"] and
          this = inv.getExpr()
        )
      }
}

class MemcpyLength extends Expr {
    MemcpyLength () {
        exists(FunctionCall call |
            call.getTarget().getName() = "memcpy" and
            this = call.getArgument(2)
        )
    }
}

class Config extends TaintTracking::Configuration {
  Config() { this = "NetworkToMemFuncLength" }

  override predicate isSource(DataFlow::Node source) {
    source.asExpr() instanceof NetworkByteSwap
  }
  override predicate isSink(DataFlow::Node sink) {
    sink.asExpr() instanceof MemcpyLength
  }
}

from Config cfg, DataFlow::PathNode source, DataFlow::PathNode sink
where cfg.hasFlowPath(source, sink)
select sink, source, sink, "Network byte swap flows to memcpy"
