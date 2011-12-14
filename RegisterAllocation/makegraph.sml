(* Page 224 *)
signature MAKEGRAPH = 
sig
    val instrs2graph : Assem.instr list ->
                        Flow.flowgraph * Flow.Graph.node list
end

structure Makegraph :> MAKEGRAPH =
struct
  structure G = FLOW.Graph
  structure A = Assem    
  
  fun instrs2graph instrs = 
  
  
  let
    val g = G.newGraph()
    
    fun initInstr([]) = 
      | initInstr(inst_h::inst_t) = 
      
      let
        val {control, def, use, ismove} = initInstr(inst_t) (* Do for each instruction *)   
        val node = G.newNode(g) 
      in
        (* OPER, LABEL, MOVE *) 
        (case inst_h of 
          A.OPER {assem,dst,src,jump} =>
            {
              control = (G.Table.Enter (control, node, inst_h)),
              def = (G.Table.Enter (def, node, dst)),
              use = (G.Table.Enter (use, node, src)),
              ismove = (G.Table.Enter (use, node, false)),       
            }
      
          | A.LABEL {assem, label} =>
            {
              control = (G.Table.Enter (control, node, inst_h)),
              def = (G.Table.Enter (def, node, nil)),
              use = (G.Table.Enter (use, node, nil)),
              ismove = (G.Table.Enter (use, node, false)),
            }

          | A.MOVE {assem,dst,src} =>
            {
              control = (G.Table.Enter (control, node, inst_h)),
              def =  (G.Table.Enter (def, net, dst)),
              use =  (G.Table.Enter (use, node, src)),
              ismove = (G.Table.Enter (use, node, true))
            }
          )
    
      end
      
      fun makeEdges (a::(b::c)) =
        
        let
          val node = G.look(control, a)
        in
          G.mk_edge {from=a, to=b}
        end
      
        | makeEdges (_) = ()
  
end