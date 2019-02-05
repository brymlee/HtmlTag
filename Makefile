all: Assert/Assert.o Assert/Assert.hi HtmlTag HtmlTagTest

Assert/Assert.o:
	"$(MAKE)" -C Assert 

Assert/Assert.hi:
	"$(MAKE)" -C Assert

HtmlTag:
	ghc HtmlTag.hs

HtmlTagTest:
	ghc -iAssert HtmlTagTest.hs
