### A Pluto.jl notebook ###
# v0.19.9

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ 9341d680-e167-11ed-1b6f-2b0f0911012e
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures
	import PlutoUI: combine
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 881fbecd-dd85-40f8-8758-eb058f8010db
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ 95cf31a2-4ce5-4e41-80ca-fa2b5f2d2b00
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 0e079409-7677-4d24-8e87-88b6b69fce49
md"""
# Derivadas e taxas de variação  $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ ebf7ef94-34b2-4386-b802-769d9992362b
md"
* **Disciplina:** 11MTMAP - Matemática Aplicada
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ 6a8c1d2c-8d8f-4ce1-921c-f97c66a3ddf9
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.	

	▶️ **Leitura obrigatória**: Stewart, Clegg, Watson (2022) - [Cálculo: volume I](https://app.minhabiblioteca.com.br/reader/books/9786555584097): Seções 2.7 e 2.8
"""

# ╔═╡ 18d64874-c6b1-4b17-9ead-2fc6978c8cea
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/6/65/Charles_Hermite_circa_1887.jpg", width=>300))
"""

# ╔═╡ 9c759fdf-a018-44f8-8aac-3247eb549c2d
md"""
!!! info ""
	"I turn away with fright and horror from the lamentable evil of functions which do not have derivatives."

	[Charles Hermite](https://en.wikipedia.org/wiki/Charles_Hermite) (1822 - 1901) - matemático francês
"""

# ╔═╡ ddd2aff4-1a08-47f7-9258-fe8a06aeb95c
md"
## Tangentes
"

# ╔═╡ d8305f01-f116-4170-9edb-3068631d3074
md"
* Agora que definimos limites e vimos como calculá-los, podemos voltar ao problema introduzido na primeira aula do nosso curso
* A saber, como obter a reta tangente a uma curva $y = f(x)$ em um ponto $P$
* Vimos que neste caso, para obter a reta tangente a uma curva em um ponto $P$, podemos traçar uma reta secante $PQ$ e fazer $Q$ aproximar-se de $P$ ao longo da curva da função, fazendo $x$ tender a $a$
* Especificamente, se uma curva $C$ tiver uma equação $y = f(x)$ e nosso objetivo é encontrar a reta tangente a $C$ no ponto $P(a, f(a))$, tomamos um ponto $Q(x, f(x))$ que seja próximo de $P$, com $x \neq a$, e calculamos a inclinação da reta secante $PQ$:

$$m_{PQ} = \frac{f(x) - f(a)}{x - a}$$

* Depois, fazemos $Q$ aproximar-se do ponto $P$ ao longo da curva $C$, fazendo $x$ tender a $a$
* Se $m_{PQ}$ tender a um número $m$, definimos a **tangente $l$** como a reta que passa por $P$ e tem inclinação $m$
"

# ╔═╡ 3cf205a4-0e27-4b77-90df-e29f92ce12e4
begin
	h_sec = @bind h Slider(range(2, 3.5, 100), default = 3.5)
	md"""
	Ponto sobre a reta secante: 
	
	h = $(h_sec)
	"""
end

# ╔═╡ ce113cb7-9e78-4276-8661-da5c2709edd1
begin
	g(x) = - (x - 3)^2 + 5
	m = 2
	plot(range(1, 4, 50), x -> g(x), label=:none, lc=:darkblue)
	plot!(range(0, 4, 50), x -> m * x, label=:none, lc=:indianred)
	plot!(range(0, 4, 50), x -> ((g(h) - g(2))/(h-2)) * (x - 2) + g(2), label=:none, lc=:darkgreen)
	xlims!(0, 5)
	ylims!(0, 6.5)
	scatter!((2, 4), label=:none, ms=7, mc=:black)
	annotate!([(1.85, 4.25, ("P", 16, :top, :black))])
	vline!([2], ls=:dash, lw=1, lc=:black, label=:none)
	vline!([h], ls=:dash, lw=1, lc=:black, label=:none)
	annotate!([(h, -0.3, ("h", 16, :top, :black))])
end

# ╔═╡ 365fe838-5b64-4767-8163-c67f148deaf7
md"""
!!! correct "Definição 5.1 - Reta Tangente"
	A **reta tangente** à curva $y = f(x)$ em um ponto $P(a, f(a))$ é a reta que passa por $P$ com inclinação:

	$$m = \lim_\limits{x \to a} \frac{f(x) - f(a)}{x - a}$$

	desde que esse limite exista.
"""

# ╔═╡ 541ddf51-c4a7-4f89-aad6-d1b21a3e88c5
md"""
> **Exemplo 1**. Encontre a equação da reta tangente à parábola $y = x^2$ no ponto $P(1, 1)$.
"""

# ╔═╡ 57401e05-3448-4f4c-8236-642f1a8a7788
md"""
!!! hint "Resolução"
	A inclinação da reta tangente será dada por:

	$$\begin{eqnarray}m &=& \lim_\limits{x\to 1} \frac{f(x) - f(1)}{x - 1} = \lim_\limits{x\to 1} \frac{x^2 - 1}{x - 1} \\ &=& \lim_\limits{x\to 1} \frac{(x+1)(x-1)}{x - 1} = \lim_\limits{x\to 1} (x + 1) = 2\end{eqnarray}$$

	Podemos, então, obter a equação da reta tangente ao ponto $(1, 1)$:
	
	$$y = 2x - 1$$
"""

# ╔═╡ a354020d-5464-4f21-8f36-27e40bf3f5f1
begin
	plot(x-> x^2, -1, 3, lc=:indianred, label=L"y = x^2")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)
	scatter!((1, 1), label=:none, ms=7, mc=:black)
	plot!(x -> 2*x - 1, lc=:blue, label=L"y = 2x - 1")
end

# ╔═╡ 86521785-63d1-4945-8d22-3780743de2df
md"""
!!! warning "Inclinação da curva no ponto"
	Às vezes nos referimos à inclinação da reta tangente como **inclinação da curva** no ponto.

	Note o que acontece com o gráfico da curva à medida que damos _zoom_ em direção ao ponto.
"""

# ╔═╡ ba62d8c4-2da8-481f-95b2-a92fe761545e
begin
	zoom = @bind zoom_reta Slider(range(3, 0.2, 100), default = 3)
	md"""
	Zoom: 
	
	zoom = $(zoom)
	"""
end

# ╔═╡ 6a3c822e-046d-4a03-9cfe-0962e7faccd0
begin
	plot(x-> x^2, -2, 4, lc=:indianred, label=L"y = x^2")
	xlims!((1 - zoom_reta)*1, (1 + zoom_reta)*1)
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)
	scatter!((1, 1), ms = 6, mc=:black, label=:none)
end

# ╔═╡ e02c5938-0274-47db-9bc9-2817f01e7e73
md"
* Podemos obter a inclinação da reta tangente de uma maneira alternativa que, às vezes, pode ser mais útil
* Defina $h = x - a$, portanto:

$$m_{PQ} = \frac{f(a + h) - f(a)}{h}$$
"

# ╔═╡ 0925e6bb-bdb4-41b5-9a37-a4a652c2d31c
md"""
!!! correct "Definição 5.2 - Reta Tangente"
	De maneira alternativa, a **reta tangente** à curva $y = f(x)$ em um ponto $P(a, f(a))$ é a reta que passa por $P$ com inclinação:

	$$m = \lim_\limits{h \to 0} \frac{f(a + h) - f(a)}{h}$$

	desde que esse limite exista.
"""

# ╔═╡ 8b555c6d-229e-4c88-bda8-9ebbbd078ce9
md"""
> **Exemplo 2**. Encontre uma equação da reta tangente à hipérbole $y = \frac{3}{x}$ no ponto $(3, 1)$
"""

# ╔═╡ 8ef626f2-a680-4ab4-ac01-399007973d92
md"""
!!! hint "Resolução"
	A inclinação da reta tangente em $(3,1)$ é:

	$$\begin{eqnarray}m &=& \lim_\limits{h \to 0}\frac{f(3+h)-f(3)}{h} = \lim_\limits{h \to 0}\frac{\frac{3}{3+h}-1}{h} \\ &=& \lim_\limits{h \to 0}\frac{\frac{3-(3+h)}{3+h}}{h} = \lim_\limits{h \to 0}\frac{-h}{h(3+h)} = -\frac{1}{3}\end{eqnarray}$$

	Portanto, a equação da reta tangente no ponto $(3, 1)$ é:

	$$y = -\frac{x}{3} + 2$$
"""

# ╔═╡ 120efbec-c9c3-4874-9731-3b5ea19219ab
begin
	plot(x-> 3/x, 0.5, 5, lc=:indianred, label=L"y = \frac{3}{x}")
	plot!(x-> 3/x, -3, -0.5, lc=:indianred, label=:none)
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)
	scatter!((3, 1), label=:none, ms=7, mc=:black)
	plot!(x -> -x/3 + 2, lc=:blue, label=L"y = -\frac{x}{3} + 2")
end

# ╔═╡ 8415623e-b1ef-47d3-81cc-58d960bd6844
md"
## Derivadas
"

# ╔═╡ b5a2cf1c-e1dd-480d-9e16-87aa3cfdd586
md"
* Os limites do tipo:

$$\lim_{h \to 0}\frac{f(a + h) - f(a)}{h}$$

surgem sempre que calculamos uma **taxa de variação** em qualquer ramo das ciências ou engenharia
* Uma vez que esse tipo de limite ocorre frequentemente, ele recebe um nome e notação especiais
"

# ╔═╡ bef1365d-a9d5-4fa1-91a3-040c650b243f
md"""
!!! correct "Definição 5.3 - Derivada de uma função em um número"
	A **derivada de uma função $f$ em um número $a$**, denotada por $f'(a)$, é dada por:

	$$f'(a) = \lim_{h \to 0}\frac{f(a + h) - f(a)}{h}$$

	se o limite existir.

	De maneira equivalente, se definirmos $x = a + h$, então, a derivada de $f$ em um ponto $a$ pode ser definida como:

	$$f'(a) = \lim_{x \to a}\frac{f(x) - f(a)}{x - a}$$

	se o limite existir
"""

# ╔═╡ 08e7de0a-889b-43b0-870a-e0a65d0bb227
md"""
> **Exemplo 3**. Encontre a derivada da função $f(x) = x^2 - 8x + 9$ nos seguintes pontos:
>
> (i) No ponto 2.
>
> (ii) No ponto $a$.
"""

# ╔═╡ df1810e2-878c-4300-b1a4-1dd5da255859
md"""
!!! hint "Resolução"
	(a) Aplicando a definição 5.3, temos:
	
	$$\begin{eqnarray}f'(2) &=& \lim_{h\to 0}\frac{f(2 + h) - f(2)}{h} \\ &=& \lim_{h\to 0}\frac{(2+h)^2 - 8(2+h) + 9 -(-3)}{h} \\
	&=& \lim_{h\to 0}\frac{4 + 4h + h^2 - 16 - 8h + 9 + 3}{h} \\
	&=& \lim_{h\to 0}\frac{h^2-4h}{h} = \lim_{h\to 0}(h-4) = -4
	\end{eqnarray}$$

	(b) Aplicando a definição 5.3, temos:
	
	$$\begin{eqnarray}f'(a) &=& \lim_{h\to 0}\frac{f(a + h) - f(a)}{h} \\ &=& \lim_{h\to 0}\frac{[(a+h)^2 - 8(a+h) + 9] -[a^2-8a+9]}{h} \\
	&=& \lim_{h\to 0}\frac{a^2 + 2ah + h^2 - 8a - 8h + 9 - a^2 + 8a - 9}{h} \\
	&=& \lim_{h\to 0}\frac{2ah + h^2 - 8h}{h} = \lim_{h\to 0}(2a + h - 8) = 2a - 8
	\end{eqnarray}$$
"""

# ╔═╡ d01f06f7-0f73-490c-8d83-79f8ad1b12ce
md"""
!!! info "Reta tangente em termos de derivada"
	A reta tangente a $y = f(x)$ no ponto $(a, f(a))$ é a reta que passa pelo ponto $(a, f(a))$ cuja inclinação é igual a $f'(a)$

	Portanto, usando a forma ponto-inclinação da equação de uma reta, temos a seguinte equação da reta tangente à curva $y = f(x)$ no ponto $(a, f(a))$:

	$$y - f(a) = f'(a)(x-a)$$
"""

# ╔═╡ aac13033-4001-42a4-8a7d-efea974b8893
md"""
> **Exemplo 4**. Encontre a equação da reta tangente à parábola $y = x^2 - 8x + 9$ no ponto $(3, -6)$.
"""

# ╔═╡ 7400d3a0-1a1b-4e32-a3f6-78fa5d07c6d8
md"""
!!! hint "Resolução"
	No Exemplo 3(b), calculamos a derivada da função $y = x^2 - 8x + 9$ no ponto $a$ e concluímos que $f'(a) = 2a - 8$. Portanto, a inclinação da reta tangente à curva $y = x^2-8x+9$ no ponto $(3, -6)$ é dada por $f'(3) = -2$.

	Concluímos, então, que a equação da reta tangente é dada por:

	$$y - (-6) = -2(x - 3) \quad \Rightarrow \quad y = -2x$$
"""

# ╔═╡ f0902a89-f3a5-4efd-8bbe-ea72e5e45d40
begin
	plot(x-> x^2 - 8x + 9, 0, 10, lc=:indianred, label=L"y = x^2 - 8x + 9")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)
	scatter!((3, -6), label=:none, ms=7, mc=:black)
	plot!(x -> -2*x, lc=:blue, label=L"y = -2x")
end

# ╔═╡ 5dfb4ca2-22aa-4a85-b450-8a056e5dc766
md"
## Taxas de variação
"

# ╔═╡ 63bf35de-a5f3-4e6b-a3ee-3e1ee4d8a81b
md"
* Suponha que a variável dependente $y$ seja uma função de uma variável independente $x$
* Portanto, quando $x$ varia de $x_1$ para $x_2$, temos que o **incremento** na variável $x$ - denotada por $\Delta x = x_2 - x_1$ levará a uma variação correspondente em $y$ de:

$$\Delta y = f(x_2) - f(x_1)$$
* O quociente das diferenças:

$$\frac{\Delta y}{\Delta x} = \frac{f(x_2) - f(x_2)}{x_2 - x_1}$$
é denominado **taxa média de variaçãod e $y$ em relação a $x$** no intervalo $[x_1, x_2]$ e pode ser interpretado como a inclinação da reta secante $PQ$ na figura abaixo
"

# ╔═╡ 0c259a67-48b8-4cb0-ae79-1a7e0d78fffb
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula5_fig1.PNG", width=>800))
Fonte: Stewart, Clegg e Watson (2022)
"""

# ╔═╡ b9be4b60-4fb9-4037-b1f8-8ca4a593b49e
md"
* Se calcularmos a taxa média de variação em intervalos cada vez menores, fazendo $x_2$ tender a $x_1$ (i.e., $\Delta x \to 0$), ao calcularmos o limite dessas taxas médias de variação, obtemos a **taxa (instantânea) de variação de $y$ em relação a $x$** em $x = x_1$
* Esta taxa instantânea pode ser interpretada, fisicamente, como a velocidade e, geometricamente, como a inclinação da reta tangente à curva $y = f(x)$ no ponto $P(x_1, f(x_1))$
"

# ╔═╡ dac1dbbb-c400-48da-a5b2-2c33b7515d86
md"""
!!! warning "Taxa instantânea de variação"
	A **taxa instantânea de variação** é dada por:

	$$\lim_{\Delta x\to 0} \frac{\Delta y}{\Delta x} = \lim_{x_2 \to x_1}\frac{f(x_2) - f(x_1)}{x_2 - x_1}$$

	Note que este limite é, simplesmente, a derivada $f'(x_1)$

	Portanto, a derivada agora tem uma nova interpretação:

	**A derivada $f'(a)$ é a taxa instantânea de variação de $y = f(x)$ em relação a $x$ quando $x = a$**
"""

# ╔═╡ 7eea26f5-dddf-4986-9fc4-3141cd91e94b
md"
* Se a derivada em um ponto for grande, a curva $y = f(x)$ é mais íngrime e, portanto, os valores de $y$ se alteram de maneira mais rápida
* Quando a derivada em um ponto é pequena, a curva é relativamente plana e, portanto, os valores de $y$ tendem a se alterar de forma mais lenta
"

# ╔═╡ 87f2e21f-c091-49e3-b0e5-cf65d43bb494
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula5_fig2.PNG", width=>800))
Fonte: Stewart, Clegg e Watson (2022)
"""

# ╔═╡ 5f3a955b-8231-4c1a-9935-b22b176c492d
md"""
> **Exemplo 5**. Um fabricante produz peças de tecido com tamanho fixo. O custo, em unidades monetárias, de produzir $x$ metros de certo tecido é dado por uma função custo $C = f(x)$.
>
> (a) Qual o significado da derivada $f'(x)$? Quais suas unidades?
>
> (b) O que significa dizer que $f'(1000) = 9$?
>
> (c) O que você supõe que seja maior, $f'(50), f'(500)$ ou $f'(5000)$?
"""

# ╔═╡ e8ab016c-c16d-4c1f-92ab-b4d41baf3c1b
md"""
!!! hint "Resolução"
	(a) A derivada $f'(x)$ é a taxa de variação instantânea de $C$ em relação a $x$, i.e., taxa de variação dos custos de produção em relação ao número de metros produzidos - **custo marginal**

	$$f'(x) = \lim_{\Delta x\to 0}\frac{\Delta C}{\Delta x}$$

	Portanto, $f'(x)$ é medida em unidades monetárias por metro.

	(b) Depois de uma produção de 1.000 metros, a taxa segundo a qual o custo de produção está aumentando é de \$9/metro (quando $x = 1000$, o custo está aumentando 9 vezes mais rápido que $x$)

	Como $\Delta x = 1$ é pequeno quando comparado a $x = 1000$, podemos ter a seguinte aproximação:

	$$f'(1000) \approx \frac{\Delta x}{\Delta x} = \Delta C$$

	e, portanto, o custo de fabricação do milésimo metro (ou do 1001º) é de aproximadamente \$9

	(c) A taxa segundo a qual o custo de produção está crescendo (por metro) provavelmente é menor quando $x = 500$ do que quando $x = 50$ (economias de escala).

	No entanto, à medida que a produção se expande, a operação em larga escala pode tornar-se ineficiente e, portanto, é possível que a taxa de crescimento dos custos pode ser maior quando a produção for muito maior: $f'(5000) > f'(500)$
"""

# ╔═╡ 295c31de-c476-4a0f-aa25-63be4290c513
md"""
> **Exemplo 6**. Seja $D(t)$ a dívida pública dos EUA em $t$. A seguinte tabela dá os valores aproximados dessa função, com estimativas da dívida ao final do ano em bilhões de dólares (de 2000 a 2016).
>
> | $t$ | $D(t)$ |
> | --- | --- |
> | 2000 | 5.662,2 |
> | 2004 | 7.596,1 |
> | 2008 | 10.699,8 |
> | 2012 | 16.432,7 |
> | 2016 | 19.976,8 |
> Fonte: US Department of the Treasury
>
> Interprete e estime os valores de $D'(2008)$
"""

# ╔═╡ 32c27614-f86b-43c1-a3cf-216502f7bec0
md"""
!!! hint "Resolução"
	A derivada $D'(2008)$ nos diz a taxa de crescimento da dívida pública norte-americana em 2008

	Pela definição, temos que:

	$$D'(2008) = \lim_{t\to 2008}\frac{D(t) - D(2008)}{t - 2008}$$

	Podemos estimar esta derivada calculando os quocientes de diferenças:

	| $t$ | Intervalo de tempo | Taxa de variação média |
	| --- | --- | --- |
	| 2000 | [2000, 2008] | 629,7 |
	| 2004 | [2004, 2008] | 775,93 |
	| 2012 | [2008, 2012] | 1433,23 |
	| 2016 | [2008, 2016] | 1159,63 |

	Portanto, $D'(2008) \in (775,93; 1433,23)$ medido em bilhões de dólares por ano.

	Supondo que a dívida pública norte-americana não oscilou consideravelmente entre 2004 e 2012, podemos estimar a taxa de crescimento em 2008 como a média entre os extremos do intervalo:

	$$D'(2008) \approx 1.105$$

	Portanto, a taxa de crescimento da dívida pública norte-americana era de aproximadamente 1.105 bilhões de dólares por ano em 2008

	💡 Uma forma alternativa seria traçar a função da dívida com relação ao tempo e estimar a inclinação da reta tangente em $t = 2008$
"""

# ╔═╡ fb081184-d184-4dae-9da8-9d20432665a6
md"
## Funções diferenciáveis
"

# ╔═╡ 56379eb0-6e59-4316-a088-51e143302f51
md"
* Anteriormente vimos a definição da derivada de uma função $f$ avaliada em um ponto $a$
* Nosso objetivo agora é permitir que este número $a$ varie
* Neste caso, temos uma nova função - chamada **derivada de $f$** - definida por:

$$f'(x) = \lim_{h\to 0}\frac{f(x + h) - f(x)}{h}$$

para qualquer número $x$ para o qual esse limite exista
"

# ╔═╡ 041aacd0-65ca-4925-a99e-d64ad12b67d5
md"""
!!! warning "Domínio da função derivada"
	O domínio de $f'$ é o conjunto $\{x| f'(x) \text{ existe}\}$ e pode ser menor que o domínio de $f$
"""

# ╔═╡ 49eea7dd-89c7-4868-ae6b-70d7c31efadd
md"""
Esboço do gráfico da derivada a partir da inclinação das retas tangentes à curva da função original
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula5_fig3.PNG", width=>800))
Fonte: Stewart, Clegg e Watson (2022)
"""

# ╔═╡ 27fff356-420a-4769-b846-d79eee9b5c7b
md"""
> **Exercício.** Se $f(x) = x^3 - x$, encontre a função derivada $f'(x)$ e compare os gráficos de $f$ e $f'$
"""

# ╔═╡ 4e5d90a6-f2b4-402a-8df1-e91a10440c0a
md"""
!!! hint "Resolução"
	Utilizando a definição, temos:

	$$\begin{eqnarray}f'(x) &=& \lim_{h\to 0}\frac{f(x + h) - f(x)}{h} \\ &=& \lim_{h\to 0}\frac{[(x + h)^3 - (x + h)] - [x^3 - x]}{h} \\ &=& \lim_{h\to 0} \frac{[x^3 + 3x^2h + 3xh^2 + h^3 - x - h - x^3 + x]}{h} \\ &=& \lim_{h\to 0}\frac{3x^2h + 3xh^2 + h^3 - h}{h} \\ &=& \lim_{h\to 0}(3x^2 + 3xh + h^2 - 1) = 3x^2 - 1\end{eqnarray}$$
"""

# ╔═╡ 3214cb20-acc0-4c4c-bc85-288a6350c568
begin
	plot(x-> x^3 - x, -10, 10, lc=:indianred, label=L"f(x) = x^3 - x")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)	
end

# ╔═╡ a4f4dc3b-788b-4d04-a81b-3c2a4ed32b02
begin
	plot(x-> 3x^2 - 1, -10, 10, lc=:indianred, label=L"f'(x) = 3x^2 - 1")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)	
end

# ╔═╡ f08cb7c4-582b-47ce-bebe-b51faafa0b88
md"""
> **Exercício.** Se $f(x) = \sqrt{x}$, encontre a função derivada $f'(x)$, compare os gráficos de $f$ e $f'$ e determine o domínio das funções
"""

# ╔═╡ 42461d4b-8314-4860-bb7d-23c41e61568a
md"""
!!! hint "Resolução"
	Utilizando a definição, temos:

	$$\begin{eqnarray}f'(x) &=& \lim_{h\to 0}\frac{f(x + h) - f(x)}{h} \\ &=& \lim_{h\to 0}\frac{\sqrt{x + h} - \sqrt{x}}{h} \\ &=& \lim_{h\to 0}\left(\frac{\sqrt{x + h} - \sqrt{x}}{h} \cdot\frac{\sqrt{x + h} + \sqrt{x}}{\sqrt{x + h} + \sqrt{x}} \right) \\ &=& \lim_{h\to 0}\frac{h}{h(\sqrt{x + h} + \sqrt{x})} \\ &=& \lim_{h\to 0}\frac{1}{\sqrt{x + h} + \sqrt{x}} = \frac{1}{2\sqrt{x}}\end{eqnarray}$$

	Domínio das funções:

	$$\begin{eqnarray} Dom(f) &=& [0, \infty) \\ Dom(f') &=& (0, \infty)\end{eqnarray}$$
"""

# ╔═╡ 0d37e5ce-0c54-4bb6-aee3-132a4f6e0bb8
begin
	plot(x-> √x, 0, 10, lc=:indianred, label=L"f(x) = \sqrt{x}")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)	
end

# ╔═╡ 72cb789a-6ba2-476c-8980-075f93e4ca51
begin
	plot(x-> 1/(2√x), 0.2, 10, lc=:indianred, label=L"f'(x) = \frac{1}{2\sqrt{x}}")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)	
end

# ╔═╡ 0a89831a-6f00-4bd2-acd6-4bd6093b782b
md"""
!!! info "Notações"
	Seja $y = f(x)$, temos as seguintes notações alternativas para a função derivada:

	$$f'(x) = y' = \frac{dy}{dx} = \frac{df}{dx} = \frac{d}{dx}f(x) = Df(x) = D_xf(x)$$

	Os símbolos $D$ e $d/dx$ são chamados **operadores diferenciais** (indicam a operação de diferenciação)

	A notação de Leibniz para a derivada de uma função avaliada em um ponto $a$ pode ser denotada por:

	$$\left.\frac{dy}{dx}\right|_{x = a} \qquad \text{ ou } \qquad \left.\frac{dy}{dx}\right]_{x = a}$$,

	que são equivalentes à notação que vimos anteriormente $f'(a)$
"""

# ╔═╡ 8a834c18-73ed-4459-a940-965e9902d376
md"""
!!! correct "Definição 5.4 - Função diferenciável"
	Uma função $f$ é derivável ou **diferenciável em $a$** se $f'(a)$ existir.

	A função $f$ é derivável ou **diferenciável em um intervalo aberto $(a,b)$** se for diferenciável em todos os números do intervalo

	O intervalo aberto determinado acima pode ser: $(a, \infty), (-\infty, a) \text{ ou } (-\infty, \infty)$
"""

# ╔═╡ 5cc706b3-4fdb-4c1b-aac5-63a58f8bd777
begin
	plot(x-> abs(x), -5, 5, lc=:indianred, label=L"f(x) = |x|")
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)	
end

# ╔═╡ 04043bc4-f3a1-469f-97eb-971745f1fb9b
begin
	plot(x-> -1, -5, 0, lc=:indianred, label=L"f'(x)")
	plot!(x-> 1, 0, 5, lc=:indianred, label=:none)
	vline!([0], lw=1, lc=:black, label=:none)
	hline!([0], lw=1, lc=:black, label=:none)
	scatter!([(0, -1), (0,1)], label=:none, ms=7, mc=:white, msc=:indianred, msw = 1)
end

# ╔═╡ 60e5f05b-f983-47a3-a3eb-80a553abd895
md"""
!!! info "Teorema 5.1"
	Se $f$ for uma função diferenciável em $a$, então, $f$ é uma função contínua em $a$
"""

# ╔═╡ c2047dc8-1b81-4c46-8c00-87818b48b522
md"""
!!! danger ""
	⚠️ A recíproca do Teorema 5.1 não é verdadeira!
	
	Existem funções que são contínuas, mas não são diferenciáveis. Por exemplo, $f(x) = |x|$ é contínua em $x = 0$, mas não é diferenciável
"""

# ╔═╡ 398c1179-d86f-44b5-b6ed-05603ef58284
md"""
!!! warning "Funções não diferenciáveis"
	Nas seguintes situações, a função $f$ não será diferenciável no ponto $a$:

	1. Existência de uma "quinta" em $a$
	2. Descontinuidade da função em $a$
	3. Existência de uma reta tangente vertical em $x = a$

	No terceiro caso, a função é contínua em $a$ e, além disso, temos:

	$$\lim_{x\to a} |f'(x)| = \infty$$
"""

# ╔═╡ 23d3cf6e-588c-434f-8322-3566218f7e54
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula5_fig4.PNG", width=>800))
Fonte: Stewart, Clegg e Watson (2022)
"""

# ╔═╡ 9bc2cba4-ab28-4daa-b60b-5f34dd46e3a0
md"
## Derivadas de ordem superior
"

# ╔═╡ 17e62022-8382-4e36-8eb5-3cd68658365a
md"
* Se $f$ for uma função diferenciável, então, sua derivada $f'$ também é uma função
* A função derivada $f'$, portanto, também pode possuir sua própria derivada
* A derivada de uma derivada é denominada **segunda derivada de $f$** ou derivada de segunda ordem
* Utilizamos as seguintes notações para a derivada de segunda ordem da função $y = f(x)$:

$$f''(x) \qquad \text{ ou } \qquad \frac{d}{dx}\left(\frac{dy}{dx}\right) = \frac{d^2y}{dx^2}$$

* A segunda derivada de uma função pode ser interpretada como a taxa de variação de uma taxa de variação
* Em termos físicos, a **aceleração** é uma derivada de segunda ordem
"

# ╔═╡ 70c75ccf-8e27-48dc-82c5-ff7349a666b8
md"
* O processo de diferenciação pode continuar
* Em termos gerais, a $n$-ésima derivada de $f$ pode ser obtida derivando a função $f$ por $n$ vezes
* Denotamos a $n$-ésima derivada da função $y = f(x)$ das seguintes formas:

$$y^{(n)} = f^{(n)}(x) = \frac{d^n y}{dx^n}$$
"

# ╔═╡ 2f7bf1d1-7ac7-4dda-a44a-3a9f8fefc60f
md"""
> **Exercício.** Seja $f(x) = x^3-x$, calcule $f''(x), f'''(x)$ e $f^{(4)}(x)$
"""

# ╔═╡ 1f4bd90c-2982-4a3c-971a-21bed7fef3a4
md"""
!!! hint "Resolução"
	Vimos, anteriormente, que $f'(x) = 3x^2 - 1$. Portanto:

	$$\begin{eqnarray}f''(x) = (f')'(x) &=& \lim_{h\to 0}\frac{f'(x + h) - f'(x)}{h} \\ &=& \lim_{h\to 0}\frac{[3(x + h)^2 - 1] - [3x^2 - 1]}{h} \\ &=& \lim_{h\to 0}\frac{3x^2 + 6xh + 3h^2 - 1 - 3x^2 + 1}{h} \\ &=& \lim_{h\to 0}\frac{6xh+3h^2}{h} = \lim_{h\to 0}(6x + 3h) = 6x
	\end{eqnarray}$$

	Como $f''(x) = 6x$, podemos calcular a derivada de terceira ordem:

	$$\begin{eqnarray}f'''(x) = (f'')'(x) &=& \lim_{h\to 0}\frac{f''(x + h) - f''(x)}{h} \\ &=& \lim_{h\to 0}\frac{6(x + h) - 6x}{h} \\ &=& \lim_{h\to 0}\frac{6h}{h} = 6
	\end{eqnarray}$$

	Por fim, dado que $f^{(3)}(x) = 6$, temos:

	$$\begin{eqnarray}f^{(4)}(x) = (f''')'(x) &=& \lim_{h\to 0}\frac{f'''(x + h) - f'''(x)}{h} \\ &=& \lim_{h\to 0}\frac{6 - 6}{h} = 0
	\end{eqnarray}$$
"""

# ╔═╡ 28ce946c-bdf4-449d-837b-397dea53b010
md"
## 📚 Bibliografia

* STEWART, J; CLEGG, D.; WATSON, S. [Cálculo – Volume 1](https://app.minhabiblioteca.com.br/reader/books/9786555584097). Tradução da 9.ed norte-americana. Cengage Learning Brasil, 2022.
"

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Measures = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
LaTeXStrings = "~1.3.0"
Measures = "~0.3.2"
Plots = "~1.38.10"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "378f739220c3378e596c6ed6d9090ffcfe2c72b8"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "8eaf9f1b4921132a4cff3f36a1d9ba923b14a481"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.1.4"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.1"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"

[[deps.BitFlags]]
git-tree-sha1 = "43b1a4a8f797c1cddadf60499a8a077d4af2cd2d"
uuid = "d1d4a3ce-64b1-5f1a-9ba4-7e7e69966f35"
version = "0.1.7"

[[deps.Bzip2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "19a35467a82e236ff51bc17a3a44b69ef35185a2"
uuid = "6e34b625-4abd-537c-b88f-471c36dfa7a0"
version = "1.0.8+0"

[[deps.Cairo_jll]]
deps = ["Artifacts", "Bzip2_jll", "CompilerSupportLibraries_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "JLLWrappers", "LZO_jll", "Libdl", "Pixman_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "4b859a208b2397a7a623a03449e4636bdb17bcf2"
uuid = "83423d85-b0ee-5818-9007-b63ccbeb887a"
version = "1.16.1+1"

[[deps.ChainRulesCore]]
deps = ["Compat", "LinearAlgebra", "SparseArrays"]
git-tree-sha1 = "c6d890a52d2c4d55d326439580c3b8d0875a77d9"
uuid = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
version = "1.15.7"

[[deps.ChangesOfVariables]]
deps = ["ChainRulesCore", "LinearAlgebra", "Test"]
git-tree-sha1 = "485193efd2176b88e6622a39a246f8c5b600e74e"
uuid = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
version = "0.1.6"

[[deps.CodecZlib]]
deps = ["TranscodingStreams", "Zlib_jll"]
git-tree-sha1 = "9c209fb7536406834aa938fb149964b985de6c83"
uuid = "944b1d66-785c-5afd-91f1-9de20f533193"
version = "0.7.1"

[[deps.ColorSchemes]]
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "PrecompileTools", "Random"]
git-tree-sha1 = "be6ab11021cd29f0344d5c4357b163af05a48cba"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.21.0"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "eb7f0f8307f71fac7c606984ea5fb2817275d6e4"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.4"

[[deps.ColorVectorSpace]]
deps = ["ColorTypes", "FixedPointNumbers", "LinearAlgebra", "SpecialFunctions", "Statistics", "TensorCore"]
git-tree-sha1 = "600cc5508d66b78aae350f7accdb58763ac18589"
uuid = "c3611d14-8923-5661-9e6a-0046d554d3a4"
version = "0.9.10"

[[deps.Colors]]
deps = ["ColorTypes", "FixedPointNumbers", "Reexport"]
git-tree-sha1 = "fc08e5930ee9a4e03f84bfb5211cb54e7769758a"
uuid = "5ae59095-9a9b-59fe-a467-6f913c188581"
version = "0.12.10"

[[deps.Compat]]
deps = ["Dates", "LinearAlgebra", "UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.1+0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "e8119c1a33d267e16108be441a287a6981ba1630"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.14.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "d1fff3a548102f48987a52a2e0d114fa97d730f0"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.13"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bad72f730e9e91c08d9427d5e8db95478a3c323d"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.4.8+0"

[[deps.FFMPEG]]
deps = ["FFMPEG_jll"]
git-tree-sha1 = "b57e3acbe22f8484b4b5ff66a7499717fe1a9cc8"
uuid = "c87230d0-a227-11e9-1b43-d7ebe4e7570a"
version = "0.4.1"

[[deps.FFMPEG_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "JLLWrappers", "LAME_jll", "Libdl", "Ogg_jll", "OpenSSL_jll", "Opus_jll", "PCRE2_jll", "Pkg", "Zlib_jll", "libaom_jll", "libass_jll", "libfdk_aac_jll", "libvorbis_jll", "x264_jll", "x265_jll"]
git-tree-sha1 = "74faea50c1d007c85837327f6775bea60b5492dd"
uuid = "b22a6f82-2f65-5046-a5b2-351ab43fb4e5"
version = "4.4.2+2"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "335bfdceacc84c5cdf16aadc768aa5ddfc5383cc"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.4"

[[deps.Fontconfig_jll]]
deps = ["Artifacts", "Bzip2_jll", "Expat_jll", "FreeType2_jll", "JLLWrappers", "Libdl", "Libuuid_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "21efd19106a55620a188615da6d3d06cd7f6ee03"
uuid = "a3f928ae-7b40-5064-980b-68af3947d34b"
version = "2.13.93+0"

[[deps.Formatting]]
deps = ["Printf"]
git-tree-sha1 = "8339d61043228fdd3eb658d86c926cb282ae72a8"
uuid = "59287772-0a20-5a39-b81b-1366585eb4c0"
version = "0.4.2"

[[deps.FreeType2_jll]]
deps = ["Artifacts", "Bzip2_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "87eb71354d8ec1a96d4a7636bd57a7347dde3ef9"
uuid = "d7e528f0-a631-5988-bf34-fe36492bcfd7"
version = "2.10.4+0"

[[deps.FriBidi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "aa31987c2ba8704e23c6c8ba8a4f769d5d7e4f91"
uuid = "559328eb-81f9-559d-9380-de523a88c83c"
version = "1.0.10+0"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "db730189e3d250d97515a91886de7e33aa8833e6"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.2"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "47a2efe07729dd508a032e2f56c46c517481052a"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.2+0"

[[deps.Gettext_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "9b02998aba7bf074d14de89f9d37ca24a1a0b046"
uuid = "78b55507-aeef-58d4-861c-77aaff3498b1"
version = "0.21.0+0"

[[deps.Glib_jll]]
deps = ["Artifacts", "Gettext_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Libiconv_jll", "Libmount_jll", "PCRE2_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "d3b3624125c1474292d0d8ed0f65554ac37ddb23"
uuid = "7746bdde-850d-59dc-9ae8-88ece973131d"
version = "2.74.0+2"

[[deps.Graphite2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "344bf40dcab1073aca04aa0df4fb092f920e4011"
uuid = "3b182d85-2403-5c21-9c21-1e1f0cc25472"
version = "1.3.14+0"

[[deps.Grisu]]
git-tree-sha1 = "53bb909d1151e57e2484c3d1b53e19552b887fb2"
uuid = "42e2da0e-8278-4e71-bc24-59509adca0fe"
version = "1.0.2"

[[deps.HTTP]]
deps = ["Base64", "CodecZlib", "Dates", "IniFile", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "37e4657cd56b11abe3d10cd4a1ec5fbdb4180263"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.7.4"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "8d511d5b81240fc8e6802386302675bdf47737b9"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.4"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "c47c5fa4c5308f27ccaac35504858d8914e102f9"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.4"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "f7be53659ab06ddc986428d3a9dcc95f6fa6705a"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.2"

[[deps.IniFile]]
git-tree-sha1 = "f550e6e32074c939295eb5ea6de31849ac2c9625"
uuid = "83e8ac13-25f8-5344-8a64-a9f2b223428f"
version = "0.5.1"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InverseFunctions]]
deps = ["Test"]
git-tree-sha1 = "49510dfcb407e572524ba94aeae2fced1f3feb0f"
uuid = "3587e190-3f89-42d0-90ee-14403ec27112"
version = "0.1.8"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.JLFzf]]
deps = ["Pipe", "REPL", "Random", "fzf_jll"]
git-tree-sha1 = "f377670cda23b6b7c1c0b3893e37451c5c1a2185"
uuid = "1019f520-868f-41f5-a6de-eb00f4b6a39c"
version = "0.1.5"

[[deps.JLLWrappers]]
deps = ["Preferences"]
git-tree-sha1 = "abc9885a7ca2052a736a600f7fa66209f96506e1"
uuid = "692b3bcd-3c85-4b1f-b108-f13ce0eb3210"
version = "1.4.1"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JpegTurbo_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "6f2675ef130a300a112286de91973805fcc5ffbc"
uuid = "aacddb02-875f-59d6-b918-886e6ef4fbf8"
version = "2.1.91+0"

[[deps.LAME_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f6250b16881adf048549549fba48b1161acdac8c"
uuid = "c1c5ebd0-6772-5130-a774-d5fcae4a789d"
version = "3.100.1+0"

[[deps.LERC_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "bf36f528eec6634efc60d7ec062008f171071434"
uuid = "88015f11-f218-50d7-93a8-a6af411a945d"
version = "3.0.0+1"

[[deps.LZO_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "e5b909bcf985c5e2605737d2ce278ed791b89be6"
uuid = "dd4b983a-f0e5-5f8d-a1b7-129d4a5fb1ac"
version = "2.10.1+0"

[[deps.LaTeXStrings]]
git-tree-sha1 = "f2355693d6778a178ade15952b7ac47a4ff97996"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.0"

[[deps.Latexify]]
deps = ["Formatting", "InteractiveUtils", "LaTeXStrings", "MacroTools", "Markdown", "OrderedCollections", "Printf", "Requires"]
git-tree-sha1 = "98dc144f1e0b299d49e8d23e56ad68d3e4f340a5"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.20"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.3"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "7.84.0+0"

[[deps.LibGit2]]
deps = ["Base64", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.10.2+0"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"

[[deps.Libffi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "0b4a5d71f3e5200a7dff793393e09dfc2d874290"
uuid = "e9f186c6-92d2-5b65-8a66-fee21dc1b490"
version = "3.2.2+1"

[[deps.Libgcrypt_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgpg_error_jll", "Pkg"]
git-tree-sha1 = "64613c82a59c120435c067c2b809fc61cf5166ae"
uuid = "d4300ac3-e22c-5743-9152-c294e39db1e4"
version = "1.8.7+0"

[[deps.Libglvnd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll", "Xorg_libXext_jll"]
git-tree-sha1 = "6f73d1dd803986947b2c750138528a999a6c7733"
uuid = "7e76a0d4-f3c7-5321-8279-8d96eeed0f29"
version = "1.6.0+0"

[[deps.Libgpg_error_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c333716e46366857753e273ce6a69ee0945a6db9"
uuid = "7add5ba3-2f88-524e-9cd5-f83b8a55f7b8"
version = "1.42.0+0"

[[deps.Libiconv_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "c7cb1f5d892775ba13767a87c7ada0b980ea0a71"
uuid = "94ce4f54-9a6c-5748-9c1c-f9c7231a4531"
version = "1.16.1+2"

[[deps.Libmount_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9c30530bf0effd46e15e0fdcf2b8636e78cbbd73"
uuid = "4b2f31a3-9ecc-558c-b454-b3730dcb73e9"
version = "2.35.0+0"

[[deps.Libtiff_jll]]
deps = ["Artifacts", "JLLWrappers", "JpegTurbo_jll", "LERC_jll", "Libdl", "Pkg", "Zlib_jll", "Zstd_jll"]
git-tree-sha1 = "3eb79b0ca5764d4799c06699573fd8f533259713"
uuid = "89763e89-9b03-5906-acba-b20f662cd828"
version = "4.4.0+0"

[[deps.Libuuid_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "7f3efec06033682db852f8b3bc3c1d2b0a0ab066"
uuid = "38a345b3-de98-5d2b-a5d3-14cd9215e700"
version = "2.36.0+0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["ChainRulesCore", "ChangesOfVariables", "DocStringExtensions", "InverseFunctions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"

[[deps.LoggingExtras]]
deps = ["Dates", "Logging"]
git-tree-sha1 = "cedb76b37bc5a6c702ade66be44f831fa23c681e"
uuid = "e6f89c97-d47a-5376-807f-9c37f3926c36"
version = "1.0.0"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.MacroTools]]
deps = ["Markdown", "Random"]
git-tree-sha1 = "42324d08725e200c23d4dfb549e0d5d89dede2d2"
uuid = "1914dd2f-81c6-5fcd-8719-6d5c9610ff09"
version = "0.5.10"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"

[[deps.MbedTLS]]
deps = ["Dates", "MbedTLS_jll", "MozillaCACerts_jll", "Random", "Sockets"]
git-tree-sha1 = "03a9b9718f5682ecb107ac9f7308991db4ce395b"
uuid = "739be429-bea8-5141-9913-cc70e7f3736d"
version = "1.1.7"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.0+0"

[[deps.Measures]]
git-tree-sha1 = "c13304c81eec1ed3af7fc20e75fb6b26092a1102"
uuid = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
version = "0.3.2"

[[deps.Missings]]
deps = ["DataAPI"]
git-tree-sha1 = "f66bdc5de519e8f8ae43bdc598782d35a25b1272"
uuid = "e1d29d7a-bbdc-5cf2-9ac0-f12de2c33e28"
version = "1.1.0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2022.2.1"

[[deps.NaNMath]]
deps = ["OpenLibm_jll"]
git-tree-sha1 = "0877504529a3e5c3343c6f8b4c0381e57e4387e4"
uuid = "77ba4419-2d1f-58cd-9bb1-8ffee604a2e3"
version = "1.0.2"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.Ogg_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "887579a3eb005446d514ab7aeac5d1d027658b8f"
uuid = "e7412a2a-1a6e-54c0-be00-318e2571c051"
version = "1.3.5+1"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.20+0"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "5b3e170ea0724f1e3ed6018c5b006c190f80e87d"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.5"

[[deps.OpenSSL_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "9ff31d101d987eb9d66bd8b176ac7c277beccd09"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.20+0"

[[deps.OpenSpecFun_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "13652491f6856acfd2db29360e1bbcd4565d04f1"
uuid = "efe28fd5-8261-553b-a9e1-b2916fc3738e"
version = "0.5.5+0"

[[deps.Opus_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "51a08fb14ec28da2ec7a927c4337e4332c2a4720"
uuid = "91d4177d-7536-5919-b921-800302f37372"
version = "1.3.2+0"

[[deps.OrderedCollections]]
git-tree-sha1 = "d321bf2de576bf25ec4d3e4360faca399afca282"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.0"

[[deps.PCRE2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "efcefdf7-47ab-520b-bdef-62a2eaa19f15"
version = "10.40.0+0"

[[deps.Parsers]]
deps = ["Dates", "SnoopPrecompile"]
git-tree-sha1 = "478ac6c952fddd4399e71d4779797c538d0ff2bf"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.8"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "b4f5d02549a10e20780a24fce72bea96b6329e29"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.40.1+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.8.0"

[[deps.PlotThemes]]
deps = ["PlotUtils", "Statistics"]
git-tree-sha1 = "1f03a2d339f42dca4a4da149c7e15e9b896ad899"
uuid = "ccf2f8ad-2431-5c83-bf29-c5338b663b6a"
version = "3.1.0"

[[deps.PlotUtils]]
deps = ["ColorSchemes", "Colors", "Dates", "PrecompileTools", "Printf", "Random", "Reexport", "Statistics"]
git-tree-sha1 = "f92e1315dadf8c46561fb9396e525f7200cdc227"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.5"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "5434b0ee344eaf2854de251f326df8720f6a7b55"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.10"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "bc2bda41d798c2e66e7c44a11007bb329b15941b"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.0.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "47e5f437cc0e7ef2ce8406ce1e7e24d44915f88d"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.3.0"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"

[[deps.Random]]
deps = ["SHA", "Serialization"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"

[[deps.RecipesBase]]
deps = ["SnoopPrecompile"]
git-tree-sha1 = "261dddd3b862bd2c940cf6ca4d1c8fe593e457c8"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.3"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "RecipesBase", "SnoopPrecompile"]
git-tree-sha1 = "e974477be88cb5e3040009f3767611bc6357846f"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.11"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.RelocatableFolders]]
deps = ["SHA", "Scratch"]
git-tree-sha1 = "90bc7a7c96410424509e4263e277e43250c05691"
uuid = "05181044-ff0b-4ac5-8273-598c1e38db00"
version = "1.0.0"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.Showoff]]
deps = ["Dates", "Grisu"]
git-tree-sha1 = "91eddf657aca81df9ae6ceb20b959ae5653ad1de"
uuid = "992d4aef-0814-514b-bc4d-f2e9a6c4116f"
version = "1.0.3"

[[deps.SimpleBufferStream]]
git-tree-sha1 = "874e8867b33a00e784c8a7e4b60afe9e037b74e1"
uuid = "777ac1f9-54b0-4bf8-805c-2214025038e7"
version = "1.1.0"

[[deps.SnoopPrecompile]]
deps = ["Preferences"]
git-tree-sha1 = "e760a70afdcd461cf01a575947738d359234665c"
uuid = "66db9d55-30c0-4569-8b51-7e840670fc0c"
version = "1.0.3"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["LinearAlgebra", "Random"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["ChainRulesCore", "IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"

[[deps.StatsAPI]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "45a7769a04a3cf80da1c1c7c60caf932e6f4c9f7"
uuid = "82ae8749-77ed-4fe6-ae5f-f523153014b0"
version = "1.6.0"

[[deps.StatsBase]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "LogExpFunctions", "Missings", "Printf", "Random", "SortingAlgorithms", "SparseArrays", "Statistics", "StatsAPI"]
git-tree-sha1 = "d1bf48bfcc554a3761a133fe3a9bb01488e06916"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.33.21"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.0"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.1"

[[deps.TensorCore]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "1feb45f88d133a655e001435632f019a9a1bcdb6"
uuid = "62fd8b95-f654-4bbd-a8a5-9c27f68ccd50"
version = "0.1.1"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"

[[deps.TranscodingStreams]]
deps = ["Random", "Test"]
git-tree-sha1 = "0b829474fed270a4b0ab07117dce9b9a2fa7581a"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.12"

[[deps.Tricks]]
git-tree-sha1 = "aadb748be58b492045b4f56166b5188aa63ce549"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.7"

[[deps.URIs]]
git-tree-sha1 = "074f993b0ca030848b897beff716d93aca60f06a"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.4.2"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"

[[deps.UnicodeFun]]
deps = ["REPL"]
git-tree-sha1 = "53915e50200959667e78a92a418594b428dffddf"
uuid = "1cfade01-22cf-5700-b092-accc4b62d6e1"
version = "0.4.1"

[[deps.Unzip]]
git-tree-sha1 = "ca0969166a028236229f63514992fc073799bb78"
uuid = "41fe7b60-77ed-43a1-b4f0-825fd5a5650d"
version = "0.2.0"

[[deps.Wayland_jll]]
deps = ["Artifacts", "Expat_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg", "XML2_jll"]
git-tree-sha1 = "ed8d92d9774b077c53e1da50fd81a36af3744c1c"
uuid = "a2964d1f-97da-50d4-b82a-358c7fce9d89"
version = "1.21.0+0"

[[deps.Wayland_protocols_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4528479aa01ee1b3b4cd0e6faef0e04cf16466da"
uuid = "2381bf8a-dfd0-557d-9999-79630e7b1b91"
version = "1.25.0+0"

[[deps.XML2_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libiconv_jll", "Pkg", "Zlib_jll"]
git-tree-sha1 = "93c41695bc1c08c46c5899f4fe06d6ead504bb73"
uuid = "02c8fc9c-b97f-50b9-bbe4-9be30ff0a78a"
version = "2.10.3+0"

[[deps.XSLT_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libgcrypt_jll", "Libgpg_error_jll", "Libiconv_jll", "Pkg", "XML2_jll", "Zlib_jll"]
git-tree-sha1 = "91844873c4085240b95e795f692c4cec4d805f8a"
uuid = "aed1982a-8fda-507f-9586-7b0439959a61"
version = "1.1.34+0"

[[deps.Xorg_libX11_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll", "Xorg_xtrans_jll"]
git-tree-sha1 = "5be649d550f3f4b95308bf0183b82e2582876527"
uuid = "4f6342f7-b3d2-589e-9d20-edeb45f2b2bc"
version = "1.6.9+4"

[[deps.Xorg_libXau_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4e490d5c960c314f33885790ed410ff3a94ce67e"
uuid = "0c0b7dd1-d40b-584c-a123-a41640f87eec"
version = "1.0.9+4"

[[deps.Xorg_libXcursor_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXfixes_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "12e0eb3bc634fa2080c1c37fccf56f7c22989afd"
uuid = "935fb764-8cf2-53bf-bb30-45bb1f8bf724"
version = "1.2.0+4"

[[deps.Xorg_libXdmcp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fe47bd2247248125c428978740e18a681372dd4"
uuid = "a3789734-cfe1-5b06-b2d0-1dd0d9d62d05"
version = "1.1.3+4"

[[deps.Xorg_libXext_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "b7c0aa8c376b31e4852b360222848637f481f8c3"
uuid = "1082639a-0dae-5f34-9b06-72781eeb8cb3"
version = "1.3.4+4"

[[deps.Xorg_libXfixes_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "0e0dc7431e7a0587559f9294aeec269471c991a4"
uuid = "d091e8ba-531a-589c-9de9-94069b037ed8"
version = "5.0.3+4"

[[deps.Xorg_libXi_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXfixes_jll"]
git-tree-sha1 = "89b52bc2160aadc84d707093930ef0bffa641246"
uuid = "a51aa0fd-4e3c-5386-b890-e753decda492"
version = "1.7.10+4"

[[deps.Xorg_libXinerama_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll"]
git-tree-sha1 = "26be8b1c342929259317d8b9f7b53bf2bb73b123"
uuid = "d1454406-59df-5ea1-beac-c340f2130bc3"
version = "1.1.4+4"

[[deps.Xorg_libXrandr_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libXext_jll", "Xorg_libXrender_jll"]
git-tree-sha1 = "34cea83cb726fb58f325887bf0612c6b3fb17631"
uuid = "ec84b674-ba8e-5d96-8ba1-2a689ba10484"
version = "1.5.2+4"

[[deps.Xorg_libXrender_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "19560f30fd49f4d4efbe7002a1037f8c43d43b96"
uuid = "ea2f1a96-1ddc-540d-b46f-429655e07cfa"
version = "0.9.10+4"

[[deps.Xorg_libpthread_stubs_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6783737e45d3c59a4a4c4091f5f88cdcf0908cbb"
uuid = "14d82f49-176c-5ed1-bb49-ad3f5cbd8c74"
version = "0.1.0+3"

[[deps.Xorg_libxcb_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "XSLT_jll", "Xorg_libXau_jll", "Xorg_libXdmcp_jll", "Xorg_libpthread_stubs_jll"]
git-tree-sha1 = "daf17f441228e7a3833846cd048892861cff16d6"
uuid = "c7cfdc94-dc32-55de-ac96-5a1b8d977c5b"
version = "1.13.0+3"

[[deps.Xorg_libxkbfile_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libX11_jll"]
git-tree-sha1 = "926af861744212db0eb001d9e40b5d16292080b2"
uuid = "cc61e674-0454-545c-8b26-ed2c68acab7a"
version = "1.1.0+4"

[[deps.Xorg_xcb_util_image_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "0fab0a40349ba1cba2c1da699243396ff8e94b97"
uuid = "12413925-8142-5f55-bb0e-6d7ca50bb09b"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxcb_jll"]
git-tree-sha1 = "e7fd7b2881fa2eaa72717420894d3938177862d1"
uuid = "2def613f-5ad1-5310-b15b-b15d46f528f5"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_keysyms_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "d1151e2c45a544f32441a567d1690e701ec89b00"
uuid = "975044d2-76e6-5fbe-bf08-97ce7c6574c7"
version = "0.4.0+1"

[[deps.Xorg_xcb_util_renderutil_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "dfd7a8f38d4613b6a575253b3174dd991ca6183e"
uuid = "0d47668e-0667-5a69-a72c-f761630bfb7e"
version = "0.3.9+1"

[[deps.Xorg_xcb_util_wm_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xcb_util_jll"]
git-tree-sha1 = "e78d10aab01a4a154142c5006ed44fd9e8e31b67"
uuid = "c22f9ab0-d5fe-5066-847c-f4bb1cd4e361"
version = "0.4.1+1"

[[deps.Xorg_xkbcomp_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_libxkbfile_jll"]
git-tree-sha1 = "4bcbf660f6c2e714f87e960a171b119d06ee163b"
uuid = "35661453-b289-5fab-8a00-3d9160c6a3a4"
version = "1.4.2+4"

[[deps.Xorg_xkeyboard_config_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Xorg_xkbcomp_jll"]
git-tree-sha1 = "5c8424f8a67c3f2209646d4425f3d415fee5931d"
uuid = "33bec58e-1273-512f-9401-5d533626f822"
version = "2.27.0+4"

[[deps.Xorg_xtrans_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "79c31e7844f6ecf779705fbc12146eb190b7d845"
uuid = "c5fb5394-a638-5e4d-96e5-b29de1b5cf10"
version = "1.4.0+3"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.12+3"

[[deps.Zstd_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "49ce682769cd5de6c72dcf1b94ed7790cd08974c"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.5+0"

[[deps.fzf_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "868e669ccb12ba16eaf50cb2957ee2ff61261c56"
uuid = "214eeab7-80f7-51ab-84ad-2988db7cef09"
version = "0.29.0+0"

[[deps.libaom_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "3a2ea60308f0996d26f1e5354e10c24e9ef905d4"
uuid = "a4ae2306-e953-59d6-aa16-d00cac43593b"
version = "3.4.0+0"

[[deps.libass_jll]]
deps = ["Artifacts", "Bzip2_jll", "FreeType2_jll", "FriBidi_jll", "HarfBuzz_jll", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "5982a94fcba20f02f42ace44b9894ee2b140fe47"
uuid = "0ac62f75-1d6f-5e53-bd7c-93b484bb37c0"
version = "0.15.1+0"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl", "OpenBLAS_jll"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.1.1+0"

[[deps.libfdk_aac_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "daacc84a041563f965be61859a36e17c4e4fcd55"
uuid = "f638f0a6-7fb0-5443-88ba-1cc74229b280"
version = "2.0.2+0"

[[deps.libpng_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Zlib_jll"]
git-tree-sha1 = "94d180a6d2b5e55e447e2d27a29ed04fe79eb30c"
uuid = "b53b4c65-9356-5827-b1ea-8c7a1a84506f"
version = "1.6.38+0"

[[deps.libvorbis_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Ogg_jll", "Pkg"]
git-tree-sha1 = "b910cb81ef3fe6e78bf6acee440bda86fd6ae00c"
uuid = "f27f6e37-5d2b-51aa-960f-b287f2bc3b7a"
version = "1.3.7+1"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.48.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+0"

[[deps.x264_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "4fea590b89e6ec504593146bf8b988b2c00922b2"
uuid = "1270edf5-f2f9-52d2-97e9-ab00b5d0237a"
version = "2021.5.5+0"

[[deps.x265_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "ee567a171cce03570d77ad3a43e90218e38937a9"
uuid = "dfaa095f-4041-5dcd-9319-2fabd8486b76"
version = "3.5.0+0"

[[deps.xkbcommon_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg", "Wayland_jll", "Wayland_protocols_jll", "Xorg_libxcb_jll", "Xorg_xkeyboard_config_jll"]
git-tree-sha1 = "9ebfc140cc56e8c2156a15ceac2f0302e327ac0a"
uuid = "d8fb68d0-12a3-5cfd-a85a-d49703b185fd"
version = "1.4.1+0"
"""

# ╔═╡ Cell order:
# ╟─9341d680-e167-11ed-1b6f-2b0f0911012e
# ╟─881fbecd-dd85-40f8-8758-eb058f8010db
# ╟─95cf31a2-4ce5-4e41-80ca-fa2b5f2d2b00
# ╟─0e079409-7677-4d24-8e87-88b6b69fce49
# ╟─ebf7ef94-34b2-4386-b802-769d9992362b
# ╟─6a8c1d2c-8d8f-4ce1-921c-f97c66a3ddf9
# ╟─18d64874-c6b1-4b17-9ead-2fc6978c8cea
# ╟─9c759fdf-a018-44f8-8aac-3247eb549c2d
# ╟─ddd2aff4-1a08-47f7-9258-fe8a06aeb95c
# ╟─d8305f01-f116-4170-9edb-3068631d3074
# ╟─3cf205a4-0e27-4b77-90df-e29f92ce12e4
# ╟─ce113cb7-9e78-4276-8661-da5c2709edd1
# ╟─365fe838-5b64-4767-8163-c67f148deaf7
# ╟─541ddf51-c4a7-4f89-aad6-d1b21a3e88c5
# ╟─57401e05-3448-4f4c-8236-642f1a8a7788
# ╟─a354020d-5464-4f21-8f36-27e40bf3f5f1
# ╟─86521785-63d1-4945-8d22-3780743de2df
# ╟─ba62d8c4-2da8-481f-95b2-a92fe761545e
# ╟─6a3c822e-046d-4a03-9cfe-0962e7faccd0
# ╟─e02c5938-0274-47db-9bc9-2817f01e7e73
# ╟─0925e6bb-bdb4-41b5-9a37-a4a652c2d31c
# ╟─8b555c6d-229e-4c88-bda8-9ebbbd078ce9
# ╟─8ef626f2-a680-4ab4-ac01-399007973d92
# ╟─120efbec-c9c3-4874-9731-3b5ea19219ab
# ╟─8415623e-b1ef-47d3-81cc-58d960bd6844
# ╟─b5a2cf1c-e1dd-480d-9e16-87aa3cfdd586
# ╟─bef1365d-a9d5-4fa1-91a3-040c650b243f
# ╟─08e7de0a-889b-43b0-870a-e0a65d0bb227
# ╟─df1810e2-878c-4300-b1a4-1dd5da255859
# ╟─d01f06f7-0f73-490c-8d83-79f8ad1b12ce
# ╟─aac13033-4001-42a4-8a7d-efea974b8893
# ╟─7400d3a0-1a1b-4e32-a3f6-78fa5d07c6d8
# ╟─f0902a89-f3a5-4efd-8bbe-ea72e5e45d40
# ╟─5dfb4ca2-22aa-4a85-b450-8a056e5dc766
# ╟─63bf35de-a5f3-4e6b-a3ee-3e1ee4d8a81b
# ╟─0c259a67-48b8-4cb0-ae79-1a7e0d78fffb
# ╟─b9be4b60-4fb9-4037-b1f8-8ca4a593b49e
# ╟─dac1dbbb-c400-48da-a5b2-2c33b7515d86
# ╟─7eea26f5-dddf-4986-9fc4-3141cd91e94b
# ╟─87f2e21f-c091-49e3-b0e5-cf65d43bb494
# ╟─5f3a955b-8231-4c1a-9935-b22b176c492d
# ╟─e8ab016c-c16d-4c1f-92ab-b4d41baf3c1b
# ╟─295c31de-c476-4a0f-aa25-63be4290c513
# ╟─32c27614-f86b-43c1-a3cf-216502f7bec0
# ╟─fb081184-d184-4dae-9da8-9d20432665a6
# ╟─56379eb0-6e59-4316-a088-51e143302f51
# ╟─041aacd0-65ca-4925-a99e-d64ad12b67d5
# ╟─49eea7dd-89c7-4868-ae6b-70d7c31efadd
# ╟─27fff356-420a-4769-b846-d79eee9b5c7b
# ╟─4e5d90a6-f2b4-402a-8df1-e91a10440c0a
# ╟─3214cb20-acc0-4c4c-bc85-288a6350c568
# ╟─a4f4dc3b-788b-4d04-a81b-3c2a4ed32b02
# ╟─f08cb7c4-582b-47ce-bebe-b51faafa0b88
# ╟─42461d4b-8314-4860-bb7d-23c41e61568a
# ╟─0d37e5ce-0c54-4bb6-aee3-132a4f6e0bb8
# ╟─72cb789a-6ba2-476c-8980-075f93e4ca51
# ╟─0a89831a-6f00-4bd2-acd6-4bd6093b782b
# ╟─8a834c18-73ed-4459-a940-965e9902d376
# ╟─5cc706b3-4fdb-4c1b-aac5-63a58f8bd777
# ╟─04043bc4-f3a1-469f-97eb-971745f1fb9b
# ╟─60e5f05b-f983-47a3-a3eb-80a553abd895
# ╟─c2047dc8-1b81-4c46-8c00-87818b48b522
# ╟─398c1179-d86f-44b5-b6ed-05603ef58284
# ╟─23d3cf6e-588c-434f-8322-3566218f7e54
# ╟─9bc2cba4-ab28-4daa-b60b-5f34dd46e3a0
# ╟─17e62022-8382-4e36-8eb5-3cd68658365a
# ╟─70c75ccf-8e27-48dc-82c5-ff7349a666b8
# ╟─2f7bf1d1-7ac7-4dda-a44a-3a9f8fefc60f
# ╟─1f4bd90c-2982-4a3c-971a-21bed7fef3a4
# ╟─28ce946c-bdf4-449d-837b-397dea53b010
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
