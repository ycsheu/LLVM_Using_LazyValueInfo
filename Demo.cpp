#include "llvm/Pass.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Instructions.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Analysis/LazyValueInfo.h"
#include "llvm/Passes/PassBuilder.h"

using namespace llvm;

namespace {

  struct Demo : public FunctionPass {
    static char ID; // Pass identification, replacement for typeid
    Demo() : FunctionPass(ID) {}

    virtual bool runOnFunction(Function &F) override {
      auto& DT = getAnalysis<DominatorTreeWrapperPass>().getDomTree();
      auto& LVI = getAnalysis<LazyValueInfoWrapperPass>().getLVI();

      for (Function::iterator BB = F.begin(); BB != F.end(); BB++){
        for (BasicBlock::iterator itrIns = (*BB).begin(); itrIns != (*BB).end(); itrIns++){
          if (itrIns->hasName()&&itrIns->getName().startswith(StringRef("base64")))
            errs() << itrIns->getName() << '\n';
	  if (itrIns->getOperand(0)->getName().startswith(StringRef("base64"))){
	    errs() << *itrIns << "   Value range is : ";
//	    LVI.printLVI(F, DT, errs());
	    Value *V = cast<Value>(itrIns);
	    BasicBlock *B = cast<BasicBlock>(BB);
	    LVI.getConstantRange(V, B).print(errs());
	    errs() << '\n';
          }
        }
      }
      return false;
    }
    void getAnalysisUsage(AnalysisUsage &AU) const override{
      AU.addRequired<DominatorTreeWrapperPass>();
      AU.addRequired<LazyValueInfoWrapperPass>();
    }
  };
}

//initialize identifier
char Demo::ID = 0;
//"Demo" is the name of pass
//"Simple demo for assignment 1 " is the explaination of your pass
static RegisterPass<Demo> GS("Demo", "Simple demo for assignment 1", false, true);
