### A Pluto.jl notebook ###
# v0.19.26

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

# ╔═╡ 3949d830-fd82-11ed-222b-4906774e18de
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures
	import PlutoUI: combine
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 628e11b8-8e29-4234-8bad-a56c2cc3e36a
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ 5ffd7e9e-240a-4d65-a880-6d61bfc7d30a
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ a7739997-4e40-47b7-8eac-eaef3b3ece05
md"""
# Regras de derivação e aplicações de derivadas $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$  $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 0629c3de-2570-42a5-9ba3-e312cfaf2c60
md"
* **Disciplina:** 11MTMAP - Matemática Aplicada
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ 49944de8-467a-4df3-9d7a-2222b29d044d
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.	

	▶️ **Leitura obrigatória**: Stewart, Clegg, Watson (2022) - [Cálculo: volume I](https://app.minhabiblioteca.com.br/reader/books/9786555584097):
	* Capítulo 3
	* Capítulo 4
"""

# ╔═╡ 981a4689-e607-4da9-ae21-c94fb73d8685
md"
## Regras de derivação
"

# ╔═╡ 7b496d13-a214-48c5-8954-1a8ae1e7f6d4
md"
| Primitiva | Derivada |
| :--- | ---: |
| $f(x) = c$ | $f'(x) = 0$ |
| $f(x) = x^n$ | $f'(x) = nx^{n-1}$ |
| $(f \pm g)(x)$ | $(f \pm g)'(x) = f'(x) \pm g'(x)$ |
| $(f \cdot g)(x)$ | $(f \cdot g)'(x) = f'(x) \cdot g(x) + f(x) \cdot g'(x)$ |
| $(\frac{f}{g})(x)$ | $(\frac{f}{g})'(x) = \frac{f'(x) \cdot g(x) - f(x) \cdot g'(x)}{g(x)^2}$ |
| $(f\circ g)(x)$ | $(f\circ g)'(x) = f'(g(x)) \cdot g'(x)$ |
| $f(x) = e^x$ | $f'(x) = e^x$ |
| $f(x) = a^x$ | $f'(x) = a^x \ln a$ |
| $f(x) = \ln x$ | $f'(x) = \frac{1}{x}$ |
"

# ╔═╡ ffa8b20f-1f57-4d69-a605-3db9dbc2a1a4
md"
* A derivada de uma derivada é chamada de segunda derivada (ou derivada de segunda ordem) é denotada por $f''(x)$
"

# ╔═╡ 11a96a89-6fbe-4cf7-96be-966a5141f2ae
md"""
!!! warning "Exercícios"
	* Encontre as derivadas das seguintes funções:
	    *  $f(x) = (2 - x^2)^3$
	    *  $f(x) = (x^3 + x^2)^{50}$
	    *  $f(x) = \sqrt{x^2 + 1}$
	    *  $f(x) = \frac{3x-5}{x-2}$
	* Encontre a primeira e segunda derivadas das seguintes funções:
	    *  $f(x) = x^3 + e^x$
	    *  $f(x) = \frac{e^x}{x}$
	    *  $f(x) = x^2\ln x$
"""

# ╔═╡ 7e09331f-1eb6-46be-980e-8003ec38711b
md"""
!!! correct "Definição (Diferencial)"
	Seja $y = f(x)$ uma função contínua e diferenciável, denote uma variação arbitrária na variável $x$ por $dx$.

	Neste caso, a expressão $f'(x)dx$ é chamada o **diferencial** de $y = f(x)$ e é denotada por $dy$, de modo que:

	$$dy = f'(x)dx$$

	Ou seja, $dy$ é proporcional a $dx$, com $f'(x)$ como o fator de proporcionalidade.
"""

# ╔═╡ fdfb28f3-ed02-4639-be0e-6ac9a95f6278
md"
## Aplicações de derivação
"

# ╔═╡ 1509d7c9-7529-4ac1-a250-b96a692c9614
md"
### Máximos e mínimos de funções univariadas
"

# ╔═╡ ca01814a-19b6-43dc-aeff-5a49f4c6597d
md"""
!!! info "Definição. (Máximos e mínimos absolutos)"
	Seja $f$ uma função e $A$ um conjunto de números contido no domínio de $f$.

	Um ponto $x$ em $A$ é:
	* um valor **máximo absoluto** de $f$ em $A$ se $f(x) \geq f(y)$ para todo $y \in A$.
	* um valor **mínimo absoluto** de $f$ em $A$ se $f(x) \leq f(y)$ para todo $y \in A$.
"""

# ╔═╡ 437a7bf7-e7f2-47f5-bb3c-4d28a18451b9
md"
* Um máximo ou mínimo absoluto, às vezes, é chamado de máximo ou mínimo **global**.
* Os valores máximos e mínimos de $f$ são chamados de **valores extremos** de $f$.
"

# ╔═╡ b3267b35-11d2-46e5-8972-f58281290c8b
begin
	plot(range(0, 6.5, 50), x -> 2sin(x) + 3, label=L"f(x) = 2sen(x) + 3", lc=:indianred)
	xlims!(0, 7)
	ylims!(0, 6)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(π/2, 5), (3π/2, 1)], ms=6, label=:none, mc=:black)
end

# ╔═╡ 72af4ebb-c629-49d1-bfcc-d0d9de07e0fa
md"
> A figura acima mostra o gráfico de uma função com um máximo absoluto em $(π/2, 5)$ e um mínimo absoluto em $(3π/2, 1)$.
"

# ╔═╡ 075b508e-c88e-41ea-81ef-2bb7d5a4950d
begin
	f(x) = 3x^4 - 16x^3 + 18x^2
	plot(range(0, 4, 50), x -> f(x), label=L"f(x) = 3x^4-16x^3+18x^2", lc=:indianred)
	xlims!(0, 4)
	ylims!(-50, 50)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(1, f(1)), (3, f(3)), (4, f(4))], ms=6, label=:none, mc=[:darkviolet, :black, :black])
end

# ╔═╡ a7615954-e770-4b6f-80c3-da3882878717
md"""
> Note, na figura acima, o gráfico de uma função $f$ que tem um máximo absoluto em $(4, 32)$ e mínimo absoluto em $(3, -27)$.
>
> Note, ainda, que se considerarmos apenas os valores de $x$ próximos (na vizinhança) de $x = 1$, então, $x = 1$ é o maior destes valores de $f(x)$ e é chamado de **valor de máximo local** de $f$.
"""

# ╔═╡ 53143d4b-c0c0-4a46-8afc-75515582b42c
md"""
!!! info "Definição 3.2. (Máximos e mínimos locais)"
	Seja $f$ uma função, e $A$ um conjunto de números contido no domínio de $f$.

	Um ponto $x \in A$ é:
	* um **ponto de máximo local** de $f$ em $A$ se existe algum $\delta > 0$ tal que $x$ é um ponto de máximo de $f$ em $A \cap (x - \delta, x + \delta)$.
	* um **ponto de mínimo local** de $f$ em $A$ se existe algum $\delta > 0$ tal que $x$ é um ponto de mínimo de $f$ em $A \cap (x - \delta, x + \delta)$.
"""

# ╔═╡ cba1a083-8bc9-48d0-b79f-8e9159b8fa14
md"""
Exemplo de mínimos/máximos locais e globais
$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig1.PNG", :width=> 600))
"""

# ╔═╡ da3eb8c3-992d-470b-aa4f-510e58d51a6e
md"
#### Exemplos
"

# ╔═╡ 325c1802-9dbd-4572-92d7-b1bf21ad1d34
md"""
$$f(x) = 3x^4 - 16x^3 + 18x^2, \qquad -1 \leq x \leq 4$$
"""

# ╔═╡ 1bf2d305-1943-485b-abb1-29c8869cd075
begin	
	plot(range(-1, 4, 50), x -> f(x), label=L"f(x) = 3x^4-16x^3+18x^2", lc=:indianred)
	xlims!(-2, 5)
	ylims!(-50, 50)
	xticks!(-2:1:5)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(-1, f(-1)), (0, f(0)), (1, f(1)), (3, f(3)), (4, f(4))], ms=6, label=:none, mc=:black)
end

# ╔═╡ 34fd9dfb-7f29-4d60-b3a5-169a39c5a5eb
md"
| Ponto | Classificação |
| :--- | ---: |
| $f(1) = 5$ | Máximo local |
| $f(-1) = 37$ | Máximo absoluto |
| $f(0) = 0$ | Mínimo local |
| $f(3) = -27$ | Mínimo local e absoluto |


* Note que $f(-1) = 37$ é um máximo absoluto mas **não** é um máximo local, pois ocorre em um extremo do intervalo
* Note que $f(4) = 32$ não é máximo local nem global
"

# ╔═╡ 2a16c10a-5a0e-4147-a6fa-3ac7fa0ccb2d
md"""
---
$$f(x) = \cos(x)$$
"""

# ╔═╡ 7b469342-1626-41ce-96d7-5b7744cb38af
begin	
	g(x) = cos(x)
	plot(range(-3π/4, 7π/2, 100), x -> g(x), label=L"f(x) = \cos(x)", lc=:indianred)
	xticks!([-π, 0, π, 2π, 3π], ["-π", "0", "π", "2π", "3π"])
	xlims!(-3, 12)
	ylims!(-2,2)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(0, g(0)), (π, g(π)), (2π, g(2π)), (3π, g(3π))], ms=6, label=:none, mc=:black)
end

# ╔═╡ cd5ae57b-64d1-48bf-8af7-fc08e9fcc571
md"
* A função $f(x) = \cos(x)$ assume seu valor máximo (local e absoluto) 1 infinitas vezes, uma vez que $\cos 2nπ = 1$ para todo inteiro $n$ e $-1\leq \cos x\leq 1$ para todo $x$.
* Da mesma forma, $\cos (2n + 1)π = -1$ é seu valor mínimo, onde $n \in \mathbb{Z}$.
"

# ╔═╡ 44f44f43-76b7-4f75-a133-154f14fcd7f3
md"
---
$$f(x) = x^2$$
"

# ╔═╡ a312b8d9-db95-4e59-a785-9372d9e19523
begin
	plot(range(-4, 4, 50), x->x^2, label=L"f(x) = x^2", lc=:indianred)
	xlims!(-5, 5)
	ylims!(-1, 20)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(0, 0)], ms=6, label=:none, mc=:black)
end

# ╔═╡ 8147c316-b90b-4c73-9a55-c7e8090ca058
md"
* Se $f(x) = x^2$, então, $f(x) \geq f(0)$ para todo $x$.
* Consequentemente, $f(0) = 0$ é o valor mínimo absoluto (e local) de $f$.
* Porém, não há um ponto mais alto sobre a parábola e, portanto, a função não tem um valor máximo.
"

# ╔═╡ 22da3e17-40e7-40d0-bc36-45e8e202f922
md"
---
$$f(x) = x^3$$
"

# ╔═╡ 1a935c85-cdf8-4652-87f2-ed968860557b
begin
	plot(range(-2, 2, 50), x->x^3, label=L"f(x) = x^3", lc=:indianred)
	xlims!(-3, 3)
	ylims!(-10, 10)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)	
end

# ╔═╡ 627ed056-0a3c-4d04-899b-df20f857d543
md"
* Essa função não tem um valor máximo absoluto, nem um valor mínimo absoluto.
* De fato, ela também não tem nenhum valor extremo local.
"

# ╔═╡ 19362b71-dc0f-4531-82d8-0c16f02eec5b
md"""
---
### Ótimos irrestritos
"""

# ╔═╡ 28bf267e-e157-4995-8b5a-5ac364352721
md"
* Passamos, agora, para o estudo da teoria da otimização sob as hipóteses de diferenciabilidade.
* Nosso principal objetivo é identificar as **condições _necessárias_** que a derivada da função $f$ deve satisfazer em um ponto de ótimo.
* Começaremos nossa análise analisando o que ficou conhecido por **otimização irrestrita**.
"

# ╔═╡ 481791b2-98dd-444a-8c1e-9d7f9b090a9b
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/f/f3/Pierre_de_Fermat.jpg", :width=>300))

[Pierre de Fermat (1601-1665) - Magistrado francês](https://pt.wikipedia.org/wiki/Pierre_de_Fermat)
"""

# ╔═╡ 6eb31322-81e6-4eb4-9607-e46a5a79f634
md"""
!!! correct "Teorema de Fermat (Condição necessária de primeira ordem)"
	Se $f$ é definida no intervalo aberto $(a,b)$ e tiver um máximo ou mínimo local em $x$ e, além disso, $f$ for diferenciável em $x$, então, $f'(x) = 0$.

	---
	▶️ Demonstração

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 258-259 🔳
"""

# ╔═╡ 64caaf9e-2512-4293-b0b7-6bc1a473413b
md"
* Portanto, dada uma função $y = f(x)$, a derivada primeira $f'(x)$ desempenha um papel importante na identificação de seus pontos ótimos.
* Isso porque, se um extremo relativo da função acontecer em um ponto $x$, ou (i) $f'(x)$ não existe, ou (ii) $f'(x) = 0$.
"

# ╔═╡ 7d053bac-33b3-4804-83eb-25c9b886823b
md"""
!!! danger "Teorema de Fermat - Observações"
	⚠️ A recíproca do Teorema de Fermat **não é verdadeira**❗❗❗
	* É possível que $f'(x) = 0$ e, ainda assim, $x$ não ser um ponto de mínimo ou de máximo para $f$.
	* Além disso, pode existir um valor extremo mesmo quando $f'(x)$ não existir.
"""

# ╔═╡ 4100e93b-2817-4614-b055-b6286b765712
begin
	plot(range(-3, 3, 50), x->x^3, lc=:indianred, label=L"f(x) = x^3")	
	xlims!(-4, 4)
	ylims!(-30, 30)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 0)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	annotate!([(0.7, -2, text(L"f'(0) = 0", :indianred))])
	annotate!([(0.1, -6, text("⚠️ não é máximo nem mínimo", :darkyellow, :left))])
end

# ╔═╡ b0347db2-5cde-4441-b7ff-730cd3ed7eb4
md"
---
Para a função $f(x) = |x|$, $f(0) = 0$ é um valor mínimo, mas $f'(0)$ não existe.
"

# ╔═╡ f51f2119-0106-4cf6-acdc-8b37eeb4371d
begin
	plot(x->abs(x), lc=:indianred, label=L"f(x) = |x|")	
	xlims!(-3, 3)
	ylims!(0, 4)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 0)], label=:none, m = (6, :indianred, stroke(1, :indianred)))		
end

# ╔═╡ 404f1960-b273-454f-be5a-511bfbe08b8e
md"
* Um dos equívocos mais comuns em cálculo têm a ver com o comportamento de uma função $f$ em uma vizinhança de $x$ quando $f'(x) = 0$.
* O ponto feito anteriormente é fundamental: **a recíproca do Teorema de Fermat não é verdadeira**!
* ⚠️ A condição $f'(x) = 0$ **não** implica que $x$ é um ponto de mínimo ou máximo local de $f$.
* Precisamente por este motivo, uma terminologia especial foi adotada para descrever números $x$ que satisfazem a condição $f'(x) = 0$.
"

# ╔═╡ 5bbb4bde-73fb-49e9-851c-b302862e08e4
md"""
!!! info "Definição (Ponto crítico)"
	Um **ponto crítico** de uma função $f$ é um número $x$ que satisfaz
	
	$$f'(x) = 0,$$

	ou se $f'(x)$ não existe.

	O valor $f(x)$ é denominado **valor crítico** de $f$.
"""

# ╔═╡ 584a2f6e-a257-411e-b975-10f3262b1dc1
md"""
> **Exercício**. Encontre os pontos críticos das seguintes funções:
>
> (a) $f(x) = x^3 - 3x^2 + 1.$
>
> (b) $f(x) = x^{3/5}(4 - x).$
"""

# ╔═╡ fc3765a7-3652-4121-8600-e6981c858b8b
md"""
!!! hint "Respostas"
	(a) Note que $f'(x)$ está definida para todo valor de $x$. Portanto, os pontos críticos são $x = 0$ e $x = 2$.

	(b) Quando $f'(x) = 0$, temos $x = \frac{3}{2}$. Além disso, $f'(x)$ não existe quando $x = 0$. Assim, os pontos críticos são $x = \frac{3}{2}$ e $x = 0$.
"""

# ╔═╡ c43dd456-ac36-4915-880c-1df7f7f6b8f8
md"""
!!! info "Definição (Funções crescentes e funções decrescentes)"
	Uma função $f$ é **crescente** em um intervalo $I$ se

	$$f(x_1) < f(x_2), \quad \text{quando } x_1 < x_2 \text{ em } I$$

	Uma função $f$ é **decrescente** em um intervalo $I$ se

	$$f(x_1) > f(x_2), \quad \text{quando } x_1 < x_2 \text{ em } I$$

"""

# ╔═╡ 5e405354-96c3-4f3e-932d-5aecbd90e816
begin
	plot(range(0, 2π, 50), x->x + 2sin(x), lc=:indianred, label=L"f(x) = x + 2sen(x)")
	xlims!(0, 2π)
	ylims!(0, 7)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2π/3, 2π/3 + 2sin(2π/3)), (4π/3, 4π/3 + 2sin(4π/3)), (2π, 2π + 2sin(2π))], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	xticks!([0, 2π/3, 4π/3, 2π], [L"0", L"\frac{2π}{3}", L"\frac{4π}{3}", L"2π"])
end

# ╔═╡ 9e3ab534-851a-48c5-ba55-5103d1bef262
md"""
!!! correct "Corolário"
	Se $f'(x) > 0$ para qualquer valor de $x$ em um intervalo, então, $f$ é uma função crescente neste intervalo.

	Se $f'(x) < 0$ para qualquer valor de $x$ em um intervalo, então, $f$ é uma função decrescente neste intervalo.

	---
	▶️ Demonstração (na lousa)

	Ver Stewart et al. - Cálculo, Vol. 1 (2022) - pp. 272 🔳
"""

# ╔═╡ d221ee4a-bffa-45ea-9245-a54a92fb7d46
md"""
> **Exercício**.
>
> Encontre onde a função $f(x) = 3x^4 - 4x^3 - 12x^2 + 5$ é crescente e onde é decrescente.
"""

# ╔═╡ 5b33c0ac-ee07-41ae-b24d-f54137491da6
md"""
> O Corolário acima nos dá informações importantes para termos uma boa ideia a respeito do gráfico de uma função.
>
> Perceba este fato ao tentar fazer um esboço da função do exercício anterior utilizando suas respostas.
"""

# ╔═╡ 4996743b-f981-4210-a02c-b76471cfcc41
begin
	func(x) = 3*x^4-4*x^3-12*x^2 + 5
	plot(range(-2, 3, 50), x->func(x), lc=:indianred, label=L"f(x) = 3x^4 - 4x^3 - 12x^2 + 5")
	xlims!(-2, 3)
	#ylims!(0, 7)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(-1, func(-1)), (0, func(0)), (2, func(2))], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 4529c42e-feb4-4ce5-9e6e-41274f892ece
md"""
!!! warning "Observação"
	Note que a recíproca do Corolário **não é verdadeira**.

	Se $f$ é crescente, é fácil ver que $f'(x) \geq 0$ para qualquer valor de $x$, no entanto, o sinal de igualdade pode ser válido para algum valor de $x$ (considere, por exemplo, $f(x) = x^3$).
"""

# ╔═╡ 74c68a75-a890-48bc-a35d-649ffadcdce8
md"""
---
### Teste da primeira derivada
"""

# ╔═╡ 0b1ee673-16f2-4b29-a9e1-7c376572187e
md"
* Toda a discussão que acabamos de fazer nos fornece um esquema geral para decidir se um ponto crítico é um ponto de máximo local, um ponto de mínimo local, ou nenhum desses casos
"

# ╔═╡ 626a5700-e192-4e26-8e07-68a2ba3ee3a2
md"""
!!! correct "Teste da Primeira Derivada"
	Seja $x$ um ponto crítico de uma função contínua $f$:

	(1) Se $f' > 0$ em algum intervalo à esquerda de $x$ e $f' < 0$ em algum intervalo à direita de $x$, então, $x$ é um ponto de máximo local.

	(2) Se $f' < 0$ em algum intervalo à esquerda de $x$ e $f' > 0$ em algum intervalo à direita de $x$, então, $x$ é um ponto de mínimo local.

	(3) Se $f'$ tem o mesmo sinal em algum intervalo à esquerda de $x$ que possui em algum intervalo à direita, então, $x$ não é nem um ponto de máximo local nem um ponto de mínimo local.
"""

# ╔═╡ ebb6aba4-57ee-4425-b2b5-4e8c6ead314c
PlutoUI.Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/aula3_fig6.PNG", :width=>800)

# ╔═╡ 6bec7bf9-c557-4bc7-b6fe-1e5b261b8a30
md"""
> **Exercícios**. Encontre os pontos de mínimo relativo ou de máximo relativo para as seguintes funções:
>
> (a) $f(x) = x^3 - 12x^2 + 36x + 8$
>
> (b) $f(x) = -2x^2 + 8x + 7$
>
> (c) $f(x) = 3 - (x - 2)^2$
>
> (d) $f(x) = \frac{8}{3x^2 + 4}$
>
> (e) $f(x) = x^3 - 1$
"""

# ╔═╡ 601c9556-20d1-4e3c-8056-6bcd29a68add
begin	
	plot(range(-1, 8, 50), x->x^3 - 12x^2 + 36x + 8, lc=:indianred, label=L"f(x) = x^3 - 12x^2 + 36x + 8")
	xlims!(-1, 8)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2, 40), (6, 8)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ f26ada95-a3f0-4c23-9591-7f2415a433d2
begin	
	plot(range(-2, 6, 50), x->-2x^2 + 8x + 7, lc=:indianred, label=L"f(x) = -2x^2 + 8x + 7")
	xlims!(-2, 6)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2, 15)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 691d5e3a-8621-4587-8324-730637bab813
begin	
	plot(range(-5, 5, 100), x->8/(3x^2 + 4), lc=:indianred, label=L"f(x) = \frac{8}{3x^2 + 4}")
	xlims!(-5, 5)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(0, 2)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ c2b6e4cf-da2b-4945-89e1-34b78bc6f476
begin	
	plot(range(-2, 2, 50), x->x^3 - 1, lc=:indianred, label=L"f(x) = x^3 - 1")
	xlims!(-2, 2)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)			
end

# ╔═╡ f65a4bc7-22d6-48e0-8d82-6fcb62b4dfe8
md"
---
### Segunda derivada, concavidade e convexidade
"

# ╔═╡ 3e04629a-7046-4b43-b904-1c15bfb0f8a2
md"
* O gráfico de uma função poder ser esboçado de maneira relativamente precisa a partir de informações fornecidas pelas suas derivadas.
* No entanto, alguns aspectos sutis podem ser revelados apenas quando analisamos a derivada segunda.
* Mas não apenas isso, as noções de concavidade e convexidade são muito mais importantes do que apenas ferramentas auxiliares no esboço de gráficos.
* Veremos mais adiante que, apesar de a localização de mínimos e máximos locais poder ser revelada por um esboço detalhado do gráfico da função, usualmente é desnecessário termos todo este trabalho.
* Existe um teste popular para máximos e mínimo que depende do comportamento da função apenas em seus pontos críticos.
"

# ╔═╡ 22627faf-b905-4ef2-8694-3d6f0131494c
md"""
!!! info "Definição (Função estritamente convexa e função estritamente côncava)"
	Uma função $f$ é **estritamente convexa** em um intervalo se, para qualquer valor de $a$ e $b$ no intervalo, o segmento de reta que une $(a, f(a))$ e $(b, f(b))$ estiver acima do gráfico de $f$.

	Uma função $f$ é **estritamente côncava** em um intervalo se, para qualquer valor de $a$ e $b$ no intervalo, o segmento de reta que une $(a, f(a))$ e $(b, f(b))$ estiver abaixo do gráfico de $f$.
"""

# ╔═╡ 41e06f30-22e7-4aa4-a8ae-a211f6292613
md"
##### Exemplo de função estritamente convexa: $f(x) = x^2 + 1$
"

# ╔═╡ b5b72791-b186-4a9e-857c-baaeeac71c8f
begin
	pontoa = @bind pa Slider(-3:0.5:3, default=-1)
	pontob = @bind pb Slider(-3:0.5:3, default=2)	

	md"""
	Ponto a: $(pontoa)
	
	Ponto b: $(pontob)	
	
	"""
end

# ╔═╡ 6b7dae50-10a4-4f4f-a1d4-895d6efd1899
begin	
	plot(range(-3, 3, 50), x->x^2 + 1, lc=:indianred, label="f convexa")
	plot!(Shape([(pa, pa^2 + 1), (pb, pb^2 + 1)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(pa, pa^2 + 1), (pb, pb^2+1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 3a2dc2e7-17c4-44a7-82d3-f090eb76cc93
md"
##### Exemplo de função estritamente côncava: $f(x) = -x^2 + 1$
"

# ╔═╡ d4e4b021-216e-4ee6-a327-bf5bb640273b
begin
	pontoaa = @bind paa Slider(-3:0.5:3, default=-1)
	pontobb = @bind pbb Slider(-3:0.5:3, default=2)	

	md"""
	Ponto a: $(pontoaa)
	
	Ponto b: $(pontobb)	
	
	"""
end

# ╔═╡ 87ed080b-fbf2-4267-9b0c-ae782954b397
begin	
	plot(range(-3, 3, 50), x->-x^2 + 1, lc=:indianred, label="f côncava")
	plot!(Shape([(paa, -paa^2 + 1), (pbb, -pbb^2 + 1)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(paa, -paa^2 + 1), (pbb, -pbb^2+1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 0dbd1af9-4b46-4a35-86f8-87c55c4b1801
md"
##### E se $f(x) = x^3$?
"

# ╔═╡ 5fb9a5bf-07f2-4e8f-8a72-533b5e114758
begin
	pontoa3 = @bind pa3 Slider(-3:0.5:3, default=-1)
	pontob3 = @bind pb3 Slider(-3:0.5:3, default=2)	

	md"""
	Ponto a: $(pontoa3)
	
	Ponto b: $(pontob3)	
	
	"""
end

# ╔═╡ 476b81b2-3d30-4d6b-ba81-4896daf74564
begin	
	plot(range(-3, 3, 50), x->x^3, lc=:indianred, label=L"f(x) = x^3")
	plot!(Shape([(pa3, pa3^3), (pb3, pb3^3)]), label=:none, lc=:deepskyblue4)
	xlims!(-3, 3)	
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	scatter!([(pa3, pa3^3), (pb3, pb3^3)], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 72eb95ea-40ef-4b54-b164-bf8542965f91
md"""
!!! correct "Teorema"
	Se $f$ é diferenciável e $f'$ é crescente (decrescente), então, $f$ é estritamente convexa (côncava).

	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 205 🔳
"""

# ╔═╡ 086a66be-95ca-4627-afaf-4470669c74c4
md"
---
### Teste da segunda derivada
"

# ╔═╡ 255f7439-a329-48d5-9316-9dd826f98ea0
md"
* Com a relação estabelecida entre a segunda derivada de uma função $f$ e a curvatura de seu gráfico, podemos estabelecer as seguintes condições para extremos locais
"

# ╔═╡ 1670f61c-4d17-4b86-ab9e-400c6933f3b6
md"""
!!! correct "Teorema - Teste da segunda derivada"
	Suponha que $f''$ seja contínua na vizinhança do ponto $a$.

	* Se $f'(a) = 0$ e $f''(a) > 0$, então, $f$ tem um mínimo local em $a$.
	* Se $f'(a) = 0$ e $f''(a) < 0$, então, $f$ tem um máximo local em $a$.
	
	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 186-187 🔳
"""

# ╔═╡ 47b6da59-1866-435b-9748-7d8347941abe
md"
* O Teorema acima pode ser aplicado à função $f(x) = x^3-x$
* Note que:

$$f'(x) = 3x^2 - 1$$

$$f''(x) = 6x$$

* Nos pontos críticos, $-\sqrt{1/3}$ e $\sqrt{1/3}$, temos:

$$f''\left(-\sqrt{1/3}\right) = -6\sqrt{1/3} < 0$$

$$f''\left(\sqrt{1/3}\right) = 6\sqrt{1/3} > 0$$

* Consequentemente, $-\sqrt{1/3}$ é um ponto de máximo local e $\sqrt{1/3}$ é um ponto de mínimo local
"

# ╔═╡ ae4b16ef-fcfa-4310-9422-bd88214b4313
begin
	plot(range(-1.5, 1.5, 50), x->x^3 - x, lc=:indianred, label=L"f(x) = x^3 - x")
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(-√(1/3), (-√(1/3)^3) + √(1/3)), (√(1/3), (√(1/3)^3) - √(1/3))], label=:none, m = (6, :indianred, stroke(1, :indianred)))	
end

# ╔═╡ 13ddcbd6-04af-44af-a7aa-2404d17a3295
md"""
!!! warning "Casos em que a segunda derivada é nula"
	Note que se $a$ é um ponto crítico de $f$, é possível que $f''(a) = 0$. Neste caso, o Teorema que acabamos de ver não fornece informações: é possível que $a$ seja um ponto de máximo local, um ponto de mínimo local, ou nenhum dos casos anteriores.

	Exemplos: $f(x) = -x^4$, $f(x) = x^4$, $f(x) = x^5$
"""

# ╔═╡ 53da1af6-43b1-4a11-92ef-2f902170f3ac
begin
	la = @layout [a b; c]
	plota = plot(range(-2, 2, 200), x -> -x^4, lc=:indianred, label=L"f(x) = -x^4")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plotb = plot(range(-2, 2, 100), x -> x^4, lc=:indianred, label=L"f(x) = x^4")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plotc = plot(range(-2, 2, 100), x -> x^5, lc=:indianred, label=L"f(x) = x^5")
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)	
	plot(plota, plotb, plotc, layout = la)
end

# ╔═╡ cfc99b71-1abb-4104-9e92-c3ffce3da9b4
md"""
!!! correct "Teorema"
	Suponha que $f''(a)$ exista.

	* Se $f$ tem um mínimo local em $a$, então, $f'(a) = 0$ e $f''(a) \geq 0$.
	* Se $f$ tem um máximo local em $a$, então, $f'(a) = 0$ e $f''(a) \leq 0$.
	
	---
	▶️ Demonstração

	Ver Spivak - Calculus (1994) - pp. 187 🔳
"""

# ╔═╡ 5900f92d-0062-411b-9433-805df0816e54
md"""
!!! danger "Resumo"
	Portanto, podemos resumir os resultados obtidos até agora na seguinte tabela:

	Condições para um extremo relativo: $y = f(x)$

	| Condição | Máximo | Mínimo |
	| :--- | ---: | ---: |
	| Necessária de primeira ordem | $f'(x) = 0$ | $f'(x) = 0 |
	| Necessária de segunda ordem | $f''(x) \leq 0$ | $f''(x) \geq 0$|
	| Suficiente de segunda ordem | $f''(x) < 0$ | $f''(x) > 0$|
"""

# ╔═╡ 01f866b3-a80f-42a7-bcf9-5555aac71f3c
md"""
> **Exercícios**.
>
> 1. Encontre o extremo relativo da seguinte função e determine se é um ponto de mínimo ou máximo local:
>
> $f(x) = 4x^2 - x$
>
> 2. Encontre os extremos relativos da seguinte função e classifique-os:
>
> $g(x) = x^3 - 3x^2 + 2$
>
> 3. CLassifique os pontos críticos da função:
>
> $h(x) = x^2 e^x$
"""

# ╔═╡ aae4dfff-6c8e-413e-acaa-647912690db9
begin
	l_exerc = @layout [a b; c]
	plot_exerc1 = plot(range(-2, 2, 50), x -> 4x^2 - x, lc=:indianred, label=L"f(x) = 4x^2 - x")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plot_exerc2 = plot(range(-2, 4, 50), x -> x^3 - 3x^2 + 2, lc=:indianred, label=L"g(x) = x^3 - 3x^2 + 2")	
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	plot_exerc3 = plot(range(-5, 1, 100), x -> x^2*exp(x), lc=:indianred, label=L"h(x) = x^2 e^x")
	vline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:solid, lc=:black, lw=0.5, label=:none)	
	plot(plot_exerc1, plot_exerc2, plot_exerc3, layout = l_exerc)
end

# ╔═╡ 294f087a-44f4-4b1f-8b92-b6986bc4ff52
md"
---
### Maximização de lucros
"

# ╔═╡ b015b65d-94f9-4a1d-90dd-11fd21d86fd4
md"
* O problema de maximização de lucros por parte de uma firma pode ser especificado como um problema de otimização estática irrestrito:
$$\max_{Q} \pi(Q) \equiv R(Q) - C(Q)$$

* **Condição necessária de primeira ordem**: quantidade ótima produzida ($Q^*$) deve satisfazer à condição de que receita marginal é igual a custo marginal
$$\frac{d\pi}{dQ} = 0 \Leftrightarrow R'(Q) = C'(Q)$$

* **Condição necessária de segunda ordem**:
$$\frac{d^2\pi}{dQ^2} \leq 0 \Leftrightarrow R''(Q) \leq C''(Q)$$
Note que, como vimos anteriormente, no caso em que $R''(Q) = C''(Q)$, não chegamos a uma conclusão definitiva sobre $Q*$ ser um máximo relativo

* **Condição suficiente de segunda ordem**:
$$\frac{d^2\pi}{dQ^2} < 0 \Leftrightarrow R''(Q) < C''(Q)$$
Portanto, avaliadas no ponto $Q^*$, a taxa de variação da receita marginal deve ser menor que a taxa de variação do custo marginal
"

# ╔═╡ 94390cca-b4ca-4bfa-a9a7-65d0f2458770
md"""
!!! info "Exemplo (Maximização de lucros)"
	Considere, respectivamente, as seguintes funções receita total e custo total:

	$$\begin{eqnarray*} R(Q) &=& 1200Q - 2Q^2, \\ C(Q) &=& Q^3 - 61,25Q^2 + 1528,5Q + 2000\end{eqnarray*}$$

	Calcule os pontos críticos da função lucro e a quantidade $Q^*$ que maximiza o lucro desta firma.
"""

# ╔═╡ be6abdcf-20c4-477d-b269-48231991963e
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
Plots = "~1.38.12"
PlutoUI = "~0.7.51"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.0"
manifest_format = "2.0"
project_hash = "a9a777e8910543ce4ec93950835e3812d07ac457"

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
deps = ["UUIDs"]
git-tree-sha1 = "7a60c856b9fa189eb34f5f8a6f6b5529b7942957"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.6.1"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.2+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

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
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

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
git-tree-sha1 = "d014972cd6f5afb1f8cd7adf000b7a966d62c304"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.5"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "f670f269909a9114df1380cc0fcaa316fff655fb"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.5+0"

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
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "ba9eca9f8bdb787c6f3cf52cb4a404c0e349a0d1"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.5"

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
git-tree-sha1 = "d75853a0bdbfb1ac815478bacd89cd27b550ace6"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.3"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

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
git-tree-sha1 = "099e356f267354f46ba65087981a77da23a279b7"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.0"

    [deps.Latexify.extensions]
    DataFramesExt = "DataFrames"
    SymEngineExt = "SymEngine"

    [deps.Latexify.weakdeps]
    DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
    SymEngine = "123dc426-2d89-5057-bbad-38513e3affd8"

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
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"

[[deps.LogExpFunctions]]
deps = ["DocStringExtensions", "IrrationalConstants", "LinearAlgebra"]
git-tree-sha1 = "0a1b7c2863e44523180fdb3146534e265a91870b"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.23"

    [deps.LogExpFunctions.extensions]
    LogExpFunctionsChainRulesCoreExt = "ChainRulesCore"
    LogExpFunctionsChangesOfVariablesExt = "ChangesOfVariables"
    LogExpFunctionsInverseFunctionsExt = "InverseFunctions"

    [deps.LogExpFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    ChangesOfVariables = "9e997f8a-9a97-42d5-a9f1-ce6bfc15e2c0"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

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
version = "2.28.2+0"

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
version = "2022.10.11"

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
version = "0.3.21+4"

[[deps.OpenLibm_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "05823500-19ac-5b8b-9628-191a04bc5112"
version = "0.8.1+0"

[[deps.OpenSSL]]
deps = ["BitFlags", "Dates", "MozillaCACerts_jll", "OpenSSL_jll", "Sockets"]
git-tree-sha1 = "51901a49222b09e3743c65b8847687ae5fc78eb2"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.4.1"

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
version = "10.42.0+0"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "a5aef8d4a6e8d81f171b2bd4be5265b01384c74c"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.5.10"

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
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.0"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "d03ef538114b38f89d66776f2d8fdc0280f90621"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.12"

    [deps.Plots.extensions]
    FileIOExt = "FileIO"
    GeometryBasicsExt = "GeometryBasics"
    IJuliaExt = "IJulia"
    ImageInTerminalExt = "ImageInTerminal"
    UnitfulExt = "Unitful"

    [deps.Plots.weakdeps]
    FileIO = "5789e2e9-d7fb-5bc7-8068-2c6fae9b9549"
    GeometryBasics = "5c1252a2-5f33-56bf-86c9-59e7332b4326"
    IJulia = "7073ff75-c697-5162-941a-fcdaad2a7d2a"
    ImageInTerminal = "d8c32880-2388-543b-8c61-d9f865259254"
    Unitful = "1986cc42-f94f-5a68-af5c-568840ba703d"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "b478a748be27bd2f2c73a7690da219d0844db305"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.51"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "259e206946c293698122f63e2b513a7c99a244e8"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

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
deps = ["PrecompileTools"]
git-tree-sha1 = "5c3d09cc4f31f5fc6af001c250bf1278733100ff"
uuid = "3cdcf5f2-1ef4-517c-9805-6587b60abb01"
version = "1.3.4"

[[deps.RecipesPipeline]]
deps = ["Dates", "NaNMath", "PlotUtils", "PrecompileTools", "RecipesBase"]
git-tree-sha1 = "45cf9fd0ca5839d06ef333c8201714e888486342"
uuid = "01d81517-befc-4cb6-b9ec-a95719d0359c"
version = "0.6.12"

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

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"

[[deps.SortingAlgorithms]]
deps = ["DataStructures"]
git-tree-sha1 = "a4ada03f999bd01b3a25dcaa30b2d929fe537e00"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.0"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "ef28127915f4229c971eb43f3fc075dd3fe91880"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.2.0"

    [deps.SpecialFunctions.extensions]
    SpecialFunctionsChainRulesCoreExt = "ChainRulesCore"

    [deps.SpecialFunctions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"

[[deps.Statistics]]
deps = ["LinearAlgebra", "SparseArrays"]
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.9.0"

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

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

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
git-tree-sha1 = "9a6ae7ed916312b41236fcef7e0af564ef934769"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.13"

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
version = "1.2.13+0"

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
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.7.0+0"

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
# ╟─3949d830-fd82-11ed-222b-4906774e18de
# ╟─628e11b8-8e29-4234-8bad-a56c2cc3e36a
# ╟─5ffd7e9e-240a-4d65-a880-6d61bfc7d30a
# ╟─a7739997-4e40-47b7-8eac-eaef3b3ece05
# ╟─0629c3de-2570-42a5-9ba3-e312cfaf2c60
# ╟─49944de8-467a-4df3-9d7a-2222b29d044d
# ╟─981a4689-e607-4da9-ae21-c94fb73d8685
# ╟─7b496d13-a214-48c5-8954-1a8ae1e7f6d4
# ╟─ffa8b20f-1f57-4d69-a605-3db9dbc2a1a4
# ╟─11a96a89-6fbe-4cf7-96be-966a5141f2ae
# ╟─7e09331f-1eb6-46be-980e-8003ec38711b
# ╟─fdfb28f3-ed02-4639-be0e-6ac9a95f6278
# ╟─1509d7c9-7529-4ac1-a250-b96a692c9614
# ╟─ca01814a-19b6-43dc-aeff-5a49f4c6597d
# ╟─437a7bf7-e7f2-47f5-bb3c-4d28a18451b9
# ╟─b3267b35-11d2-46e5-8972-f58281290c8b
# ╟─72af4ebb-c629-49d1-bfcc-d0d9de07e0fa
# ╟─075b508e-c88e-41ea-81ef-2bb7d5a4950d
# ╟─a7615954-e770-4b6f-80c3-da3882878717
# ╟─53143d4b-c0c0-4a46-8afc-75515582b42c
# ╟─cba1a083-8bc9-48d0-b79f-8e9159b8fa14
# ╟─da3eb8c3-992d-470b-aa4f-510e58d51a6e
# ╟─325c1802-9dbd-4572-92d7-b1bf21ad1d34
# ╟─1bf2d305-1943-485b-abb1-29c8869cd075
# ╟─34fd9dfb-7f29-4d60-b3a5-169a39c5a5eb
# ╟─2a16c10a-5a0e-4147-a6fa-3ac7fa0ccb2d
# ╟─7b469342-1626-41ce-96d7-5b7744cb38af
# ╟─cd5ae57b-64d1-48bf-8af7-fc08e9fcc571
# ╟─44f44f43-76b7-4f75-a133-154f14fcd7f3
# ╟─a312b8d9-db95-4e59-a785-9372d9e19523
# ╟─8147c316-b90b-4c73-9a55-c7e8090ca058
# ╟─22da3e17-40e7-40d0-bc36-45e8e202f922
# ╟─1a935c85-cdf8-4652-87f2-ed968860557b
# ╟─627ed056-0a3c-4d04-899b-df20f857d543
# ╟─19362b71-dc0f-4531-82d8-0c16f02eec5b
# ╟─28bf267e-e157-4995-8b5a-5ac364352721
# ╟─481791b2-98dd-444a-8c1e-9d7f9b090a9b
# ╟─6eb31322-81e6-4eb4-9607-e46a5a79f634
# ╟─64caaf9e-2512-4293-b0b7-6bc1a473413b
# ╟─7d053bac-33b3-4804-83eb-25c9b886823b
# ╟─4100e93b-2817-4614-b055-b6286b765712
# ╟─b0347db2-5cde-4441-b7ff-730cd3ed7eb4
# ╟─f51f2119-0106-4cf6-acdc-8b37eeb4371d
# ╟─404f1960-b273-454f-be5a-511bfbe08b8e
# ╟─5bbb4bde-73fb-49e9-851c-b302862e08e4
# ╟─584a2f6e-a257-411e-b975-10f3262b1dc1
# ╟─fc3765a7-3652-4121-8600-e6981c858b8b
# ╟─c43dd456-ac36-4915-880c-1df7f7f6b8f8
# ╟─5e405354-96c3-4f3e-932d-5aecbd90e816
# ╟─9e3ab534-851a-48c5-ba55-5103d1bef262
# ╟─d221ee4a-bffa-45ea-9245-a54a92fb7d46
# ╟─5b33c0ac-ee07-41ae-b24d-f54137491da6
# ╟─4996743b-f981-4210-a02c-b76471cfcc41
# ╟─4529c42e-feb4-4ce5-9e6e-41274f892ece
# ╟─74c68a75-a890-48bc-a35d-649ffadcdce8
# ╟─0b1ee673-16f2-4b29-a9e1-7c376572187e
# ╟─626a5700-e192-4e26-8e07-68a2ba3ee3a2
# ╟─ebb6aba4-57ee-4425-b2b5-4e8c6ead314c
# ╟─6bec7bf9-c557-4bc7-b6fe-1e5b261b8a30
# ╟─601c9556-20d1-4e3c-8056-6bcd29a68add
# ╟─f26ada95-a3f0-4c23-9591-7f2415a433d2
# ╟─691d5e3a-8621-4587-8324-730637bab813
# ╟─c2b6e4cf-da2b-4945-89e1-34b78bc6f476
# ╟─f65a4bc7-22d6-48e0-8d82-6fcb62b4dfe8
# ╟─3e04629a-7046-4b43-b904-1c15bfb0f8a2
# ╟─22627faf-b905-4ef2-8694-3d6f0131494c
# ╟─41e06f30-22e7-4aa4-a8ae-a211f6292613
# ╟─b5b72791-b186-4a9e-857c-baaeeac71c8f
# ╟─6b7dae50-10a4-4f4f-a1d4-895d6efd1899
# ╟─3a2dc2e7-17c4-44a7-82d3-f090eb76cc93
# ╟─d4e4b021-216e-4ee6-a327-bf5bb640273b
# ╟─87ed080b-fbf2-4267-9b0c-ae782954b397
# ╟─0dbd1af9-4b46-4a35-86f8-87c55c4b1801
# ╟─5fb9a5bf-07f2-4e8f-8a72-533b5e114758
# ╟─476b81b2-3d30-4d6b-ba81-4896daf74564
# ╟─72eb95ea-40ef-4b54-b164-bf8542965f91
# ╟─086a66be-95ca-4627-afaf-4470669c74c4
# ╟─255f7439-a329-48d5-9316-9dd826f98ea0
# ╟─1670f61c-4d17-4b86-ab9e-400c6933f3b6
# ╟─47b6da59-1866-435b-9748-7d8347941abe
# ╟─ae4b16ef-fcfa-4310-9422-bd88214b4313
# ╟─13ddcbd6-04af-44af-a7aa-2404d17a3295
# ╟─53da1af6-43b1-4a11-92ef-2f902170f3ac
# ╟─cfc99b71-1abb-4104-9e92-c3ffce3da9b4
# ╟─5900f92d-0062-411b-9433-805df0816e54
# ╟─01f866b3-a80f-42a7-bcf9-5555aac71f3c
# ╟─aae4dfff-6c8e-413e-acaa-647912690db9
# ╟─294f087a-44f4-4b1f-8b92-b6986bc4ff52
# ╟─b015b65d-94f9-4a1d-90dd-11fd21d86fd4
# ╟─94390cca-b4ca-4bfa-a9a7-65d0f2458770
# ╟─be6abdcf-20c4-477d-b269-48231991963e
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
