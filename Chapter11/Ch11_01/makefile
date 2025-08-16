# ========= Configuración general =========
TARGET  := Ch11_01
INCDIR1 := .
INCDIR2 := ../../Include
OBJDIR  := obj

# Detectar arquitectura de macOS (arm64 Apple Silicon / x86_64 Intel)
ARCH := $(shell uname -m)
ifeq ($(ARCH),arm64)
  ARCHFLAG := -arch arm64
else ifeq ($(ARCH),x86_64)
  ARCHFLAG := -arch x86_64
else
  $(warning Arquitectura no reconocida: $(ARCH). Se compilará sin -arch.)
  ARCHFLAG :=
endif

# Compiladores/Ensamblador (clang/clang++)
CC      := clang
CXX     := clang++
AS      := clang

# Flags comunes
WARN    := -Wall -Wextra -Wpedantic
OPT     := -O3
STDCPP  := -std=c++14
DEBUG   := -g

CPPINCLUDES := -I$(INCDIR1) -I$(INCDIR2)

CXXFLAGS := $(ARCHFLAG) $(OPT) $(STDCPP) $(WARN) $(DEBUG) $(CPPINCLUDES)
CFLAGS   := $(ARCHFLAG) $(OPT) -std=c11 $(WARN) $(DEBUG) $(CPPINCLUDES)

# Ensamblador LLVM integrado:
# - Para .s (sin preprocesado C): pasar includes al ensamblador: -Wa,-I<dir>
# - Para .S (con preprocesado C): usar -I<dir> normales
ASFLAGS_s  := $(ARCHFLAG) $(DEBUG) -x assembler -Wa,-I$(INCDIR1) -Wa,-I$(INCDIR2)
ASFLAGS_S  := $(ARCHFLAG) $(DEBUG) -x assembler-with-cpp $(CPPINCLUDES)

# ========= Descubrimiento de fuentes =========
CPPINCFILES1 := $(wildcard $(INCDIR1)/*.h)
CPPINCFILES2 := $(wildcard $(INCDIR2)/*.h)
ASMINCFILES1 := $(wildcard $(INCDIR1)/*.inc)
ASMINCFILES2 := $(wildcard $(INCDIR2)/*.inc)

CPPFILES     := $(wildcard *.cpp)
CPPOBJFILES_ := $(CPPFILES:.cpp=.o)
CPPOBJFILES  := $(patsubst %, $(OBJDIR)/%, $(CPPOBJFILES_))

# Soportar tanto .s (asm puro) como .S (asm con preprocesador)
ASMFILES_s     := $(wildcard *.s)
ASMFILES_S     := $(wildcard *.S)
ASMOBJFILES_s_ := $(ASMFILES_s:.s=.o)
ASMOBJFILES_S_ := $(ASMFILES_S:.S=.o)
ASMOBJFILES_s  := $(patsubst %, $(OBJDIR)/%, $(ASMOBJFILES_s_))
ASMOBJFILES_S  := $(patsubst %, $(OBJDIR)/%, $(ASMOBJFILES_S_))

OBJFILES := $(CPPOBJFILES) $(ASMOBJFILES_s) $(ASMOBJFILES_S)

# Crear carpeta de objetos si no existe
$(shell mkdir -p $(OBJDIR))

# ========= Enlazado =========
$(TARGET): $(OBJFILES)
	$(CXX) $(ARCHFLAG) $(OBJFILES) -o $(TARGET)

# ========= Reglas de compilación =========
# Nota: recompila si cambian includes
$(OBJDIR)/%.o: %.cpp $(CPPINCFILES1) $(CPPINCFILES2)
	$(CXX) $(CXXFLAGS) -c $< -o $@

# .s -> asm puro (sin preprocesado C)
$(OBJDIR)/%.o: %.s $(ASMINCFILES1) $(ASMINCFILES2)
	$(AS) $(ASFLAGS_s) -c $< -o $@

# .S -> asm con preprocesado C (#include, macros, etc.)
$(OBJDIR)/%.o: %.S $(ASMINCFILES1) $(ASMINCFILES2) $(CPPINCFILES1) $(CPPINCFILES2)
	$(AS) $(ASFLAGS_S) -c $< -o $@

# ========= Utilidades =========
.PHONY: clean
clean:
	rm -f $(TARGET)
	rm -rf $(OBJDIR)
