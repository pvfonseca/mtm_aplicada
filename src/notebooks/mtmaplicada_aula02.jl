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

# ╔═╡ 8a03f030-bda9-11ed-35ca-d1e52878d401
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures
	import PlutoUI: combine
	using GLM
	using DataFrames
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ 093eb733-6578-4b97-b04f-ca1c796ceea8
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ de3cdefd-e381-4046-80f9-7b542b1b7c7d
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 01314865-c37a-4f0c-8081-2eedc6968ec2
md"""
# Funções $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ 0f908f8c-a8e5-4a45-a551-c92db81b05c8
md"
* **Disciplina:** 11MTMAP - Matemática Aplicada
* **Data:** 08/03/2023
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ 9bb79ac7-b24b-4e46-b9f8-0fb248cab1fb
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.
"""

# ╔═╡ 79a3afd4-4f05-4501-a269-694820f35feb
md"""
## Funções univariadas
"""

# ╔═╡ 35ae248e-e8d2-4c8c-8731-8bfe7fcf29f2
md"""
!!! correct "Definição 2.1 (Função)"
	Uma função $f$ é uma lei que associa, a cada elemento $x$ em um conjunto domínio $D$, exatamente um elemento, chamado $f(x)$, no conjunto contra-domínio $E$.
"""

# ╔═╡ a80986af-ef58-4704-b464-78a8ef2c0b67
md"
* Dizemos que uma função $f$ é um mapeamento de um conjunto $D$ em um outro conjunto $E$, e denotamos por:
$$f: D \to E$$
* O conjunto de todos os valores possíveis de $f(x)$ obtidos quando $x$ varia por todo o domínio é chamado **imagem de $f$**
"

# ╔═╡ 77172b5f-7cbb-4056-a876-f5c1a59e16e2
md"""
Formas de representação de uma função:

| Método | Descrição |
| :--- | ---: |
| Verbalmente | Descrição com palavras |
| Numericamente | Tabela de valores |
| Visualmente | Gráfico |
| Algebricamente | Fórmula explícita |
"""

# ╔═╡ 31a5a354-04dc-44de-8a5d-fae8f5458f2c
md"""
!!! correct "Definição 2.2 (Gráfico de uma função)"
	Se $f$ é uma função com domínio $D$, então, seu **gráfico** será o conjunto de pares ordenados:

	$$\{x, f(x)| x \in D\}$$
"""

# ╔═╡ b5da0f74-1bec-41af-8f38-3c82713bbec3
md"""

| Ano | População mundial (milhões) |
| :---: | ---: |
| 1900	| 1.650 |
| 1910	| 1.750 |
| 1920	| 1.860 |
| 1930	| 2.070 |
| 1940	| 2.300 |
| 1950	| 2.560 |
| 1960	| 3.040 |
| 1970	| 3.710 |
| 1980	| 4.450 |
| 1990	| 5.280 |
| 2000	| 6.080 |
| 2010	| 6.870 |
"""

# ╔═╡ 49f4736a-1115-4e37-abd6-906ca0621d37
begin
	populacao = [1650, 1750, 1860, 2070, 2300, 2560, 3040, 3710, 4450, 5280, 6080, 6870]
	ano = 1900:10:2010	
	data = DataFrame(X=ano, Y=populacao)
	ols = lm(@formula(Y ~ X), data)
	scatter(ano, populacao, label="População Mundial")
	plot!(ano, (1.43653*10^3).*(1.01395).^(ano .- 1900), lc=:indianred, label="Aproximação (exponencial)")
	plot!(ano, coef(ols)[1] .+ coef(ols)[2] .* ano, lc=:black, label="Aproximação (linear)")
end

# ╔═╡ dce4b713-f0c0-422b-9739-7c83a4750a8d
begin	
	data_log = DataFrame(X=ano, Y=log.(populacao))
	ols_log = lm(@formula(Y ~ X), data_log)
	scatter(ano, log.(populacao), label="População Mundial (log)")
	plot!(ano, coef(ols_log)[1] .+ coef(ols_log)[2] .* ano, lc=:black, label="Aproximação (linear)")
end

# ╔═╡ 16ea9617-126a-484e-bb26-efd1b03f99c6
md"""
> **Exercício**. Se $f(x) = 2x^2 - 5x + 1$ e $h \neq 0$, avalie $\frac{f(a + h) - f(a)}{h}$
"""

# ╔═╡ 151c7c52-fe14-4774-996a-5d42dca4fd1c
md"""
!!! hint "Resposta"
	A expressão $\frac{f(a + h) - f(a)}{h}$ é chamada de **quociente de diferenças** e ocorre com frequência no cálculo. Ela representa a taxa média de variação de $f(x)$ entre os pontos $x = a$ e $x = a + h$.

	Para esse exercício específico, temos:

	$$\frac{f(a + h) - f(a)}{h} = 4a + 2h - 5.$$
"""

# ╔═╡ a5d93ca6-f24d-48ac-a30c-6ef21efdfe4a
md"""
Considerando a figura abaixo, qual(is) da(s) imagem(s) representa(m) uma função?

$(Resource("https://raw.githubusercontent.com/pvfonseca/MetodosQuantitativos/main/notas/figures/spivak_functions.PNG", :width => 400))
"""

# ╔═╡ 714632a2-8035-46e1-a9dc-6b0206150cb7
md"
Exemplos de funções
"

# ╔═╡ 79243ee6-95a9-41cb-8258-2ceee8d56d36
begin
	l = @layout [a b; c d]
	p1 = plot(range(-2, -0.1, 100), x -> 1/x, lc=:indianred, label=L"f(x) = \frac{1}{x}")
	plot!(range(0.1, 2, 100), x -> 1/x, lc=:indianred, label=:none)
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	p2 = plot(range(-2, -0.01, 100), x -> 1/x^2, lc=:indianred, label=L"f(x) = \frac{1}{x^2}")
	plot!(range(0.01, 2, 100), x -> 1/x^2, lc=:indianred, label=:none)
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	ylims!(0, 50)
	p3 = plot(range(-6, 6, 100), x -> 1/(1 + x^2), lc=:indianred, label=L"f(x) = \frac{1}{1 + x^2}")
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	p4 = plot(range(-6, 6, 100), x -> x/(1 + x^2), lc=:indianred, label=L"f(x) = \frac{x}{1 + x^2}")
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	plot(p1, p2, p3, p4, layout = l)
end

# ╔═╡ 60046e4b-ac01-429c-8481-d7bd776744c9
md"
---
### Funções definidas por partes
"

# ╔═╡ d933f5aa-b214-4c5f-ba5e-797e6ec5a648
md"
* São funções que são definidas por fórmulas distintas em diferentes partes de seus domínios.
"

# ╔═╡ 154dbf13-4586-4721-adf1-e0920c2799ed
md"
$$f(x) = \begin{cases} 1-x, & \quad x \leq -1 \\ x^2, & \quad x>-1\end{cases}$$
"

# ╔═╡ 2d5f24e4-92f6-4c68-8c09-6d4ad92c5c69
begin
	plot(range(-4, -1, 100), x -> 1 - x, lc=:indianred, label=L"f(x)")
	plot!(range(-1, 3, 100), x -> x^2, lc=:indianred, label=:none)
	hline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	scatter!([(-1, 1)], label=:none, m = (6, :white, stroke(1, :indianred)))
	scatter!([(-1, 2)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
end

# ╔═╡ 292ee2c9-5f36-4a0d-9548-f0bcada8e9d5
md"
$$f(x) = |x|$$
"

# ╔═╡ 652fd098-dcfc-49e2-b4a2-8c2789f775d1
begin
	plot(range(-3, 3, 300), x -> abs(x), lc=:indianred, label=L"f(x) = |x|")
	hline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 5d66531b-ef38-4d57-bdc3-c5277d5fb0a1
md"""
> Encontre uma função definida por partes que possua o seguinte gráfico:
"""

# ╔═╡ 6ad44887-a910-4e1a-a700-fd6eda342299
begin
	plot(range(0, 1, 100), x -> x, lc=:indianred, label=L"f(x)")
	plot!(range(1, 2, 100), x -> 2-x, lc=:indianred, label=:none)
	plot!(range(2, 5, 100), x -> 0, lc=:indianred, label=:none)
	ylims!(0,3)
	hline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ ab3c6cd9-0e05-4dda-b3ce-76afc1f4fcf1
md"""
!!! hint "Resposta"
	A função definida por:

	$$f(x) = \begin{cases} x, &\quad 0\leq x \leq 1 \\ 2-x, &\quad 1< x\leq 2 \\ 0, &\quad x>2\end{cases}$$
"""

# ╔═╡ 875a957f-aeb3-4cd3-9cd0-ab5ed075eb47
md"
---
### Funções pares e funções ímpares
"

# ╔═╡ ff813602-eb49-4d6b-87e5-48a5923ce37a
md"""
!!! correct "Definição 2.3 (Funções pares e funções ímpares)"
	A função $f$ é uma **função par** se em todo o seu domínio, temos:

	$$f(-x) = f(x)$$

	A função $f$ é uma **função ímpar** se em todo o seu domínio, temos:

	$$f(-x) = -f(x)$$

"""

# ╔═╡ 6358a6f0-d7cd-40e7-a067-c570bef940f5
begin
	plot(range(-3, 3, 300), x -> x^5 + x, lc=:indianred, label=L"f(x) = x^5 + x")
	hline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ d0a26769-1a72-4f46-a1ce-79c2b7a6547b
begin
	plot(range(-1.5, 1.5, 300), x -> 1-x^4, lc=:indianred, label=L"f(x) = 1-x^4")
	hline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 8792d2d4-963b-41e8-8889-f28efef53af8
begin
	plot(range(-3, 5, 300), x -> 2x-x^2, lc=:indianred, label=L"f(x) = 2x-x^2")
	hline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:solid, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 1b57ca0f-0046-4bdb-b6ae-33bd5148e023
md"
### Funções crescentes e decrescentes
"

# ╔═╡ aa71d767-ef6c-4edb-95cc-58d723c1e9f7
md"""
!!! correct "Definição 2.4 (Funções crescentes e funções decrescentes)"
	Uma função $f$ é **crescente** em um intervalo $I$ se

	$$f(x_1) < f(x_2), \quad \text{quando } x_1 < x_2 \text{ em } I$$

	Uma função $f$ é **decrescente** em um intervalo $I$ se

	$$f(x_1) > f(x_2), \quad \text{quando } x_1 < x_2 \text{ em } I$$

"""

# ╔═╡ 2be64749-c1f6-4d92-ad94-b286e30bff36
begin
	plot(range(0, 2π, 100), x->x + 2sin(x), lc=:indianred, label=L"f(x) = x + 2sen(x)")
	xlims!(0, 2π)
	ylims!(0, 7)
	hline!([0], lc=:black, lw=1, label=:none, ls=:solid)
	vline!([0], lc=:black, lw=1, label=:none, ls=:solid)		
	scatter!([(2π/3, 2π/3 + 2sin(2π/3)), (4π/3, 4π/3 + 2sin(4π/3)), (2π, 2π + 2sin(2π))], label=:none, m = (6, :indianred, stroke(1, :indianred)))
	xticks!([0, 2π/3, 4π/3, 2π], [L"0", L"\frac{2π}{3}", L"\frac{4π}{3}", L"2π"])
end

# ╔═╡ fe8e8811-5133-4a85-b67a-6b9cec0fdbb2
md"
## Algumas funções essenciais
"

# ╔═╡ f974b3eb-ef26-4083-ba15-dc4db1be1c00
md"
### Função linear

$$y = f(x) = mx + b$$

| Parâmetro |      Significado      |
|:-----------|-------------:|
| $m$  |  coeficiente angular da reta |
| $b$  |    intersecção com eixo $y$   |

"

# ╔═╡ d1dcf742-6a69-4808-8f3d-05b13ba852ae
begin
	coef_angular = @bind m Slider(-2:0.1:2, default=1)
	inter = @bind b Slider(0:0.1:3, default=1)	

	md"""
	* Qual o efeito sobre o gráfico de uma função linear quando os coeficientes se alteram?
	
	Coeficiente angular: $(coef_angular)
	
	Intercepto: $(inter)
	"""
end

# ╔═╡ b8479ad6-7895-4c28-88aa-3eb390307795
begin
	plot(range(-3, 3, 200), x-> m*x + b, lc=:indianred, label="f(x) = $(m)x + $(b)")
	plot!(range(-3, 3, 200), x-> x + 1, lc=:navyblue, label=L"f(x) = x + 1")
	xlims!(-3, 3)
	ylims!(-6, 6)
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
end

# ╔═╡ d009f5ad-8c87-48c7-a110-ce840bdcb4ff
md"""
!!! info "Exemplo 1."
	Considere o processo produtivo de uma empresa hipotética cuja função de custo é descrita por uma função linear da forma: $C(q) = mq + b$. Suponha, ainda, que o custo total de produção desta firma é de R\$525,00 quando ela produz 150 unidades e, além disso, quando produz 400 unidades, os custos são de R\$700,00. Pede-se:

	(i) Calcule	o custo fixo de produção desta empresa (i.e., o custo que ela incorrerá mesmo decidindo não produzir).

	(ii) Qual a parametrização da função custo total desta empresa?

	(iii) Esboce o gráfico da função custo no $\mathbb{R}_+$.

	(iv) Suponha que a empresa esteja produzindo $q$ unidades. Qual o custo incorrerá se decidir produzir uma unidade adicional de produto?
"""

# ╔═╡ e06b7eda-7036-484e-83ed-243618cb487d
md"""
!!! info "Exemplo 2."
	Os níveis médios de dióxido de carbono na atmosfera, medidos em partes por milhão no Observatório de Mauna Loa em Hilo, Havaí, de 1980 a 2016, são representados na tabela abaixo:

	| Ano | Nível de $CO_2$ (ppm) |
	| :--- | ---: |
	| 1980 | 338,7 |
	| 1984 | 344,4 |
	| 1988 | 351,5 |
	| 1992 | 356,3 |
	| 1996 | 362,4 |
	| 2000 | 369,4 |
	| 2004 | 377,5 |
	| 2008 | 385,6 |
	| 2012 | 393,8 |
	| 2016 | 404,2 |

	Utilizando os dados da tabela, vamos formular um modelo para o nível de dióxido de carbono.
"""

# ╔═╡ 8125c626-a72c-42b9-8544-b923494b0b67
md"
* Vamos representar o conjunto de dados na Tabela em um gráfico de dispersão
"

# ╔═╡ 64a6c014-7756-40c9-833f-4b3522755714
begin
	periodos = 1980:4:2016
	medidas = [338.7, 344.4, 351.5, 356.3, 362.4, 369.4, 377.5, 385.6, 393.8, 404.2]
	nivelco2 = DataFrame(X = periodos, Y = medidas)	
	scatter(periodos, medidas, label="Nível de CO2")	
end

# ╔═╡ 82ab9b17-dc93-406e-8288-2a2bd43e5e9a
md"
* Note que o conjunto de dados apresenta um comportamento similar ao gráfico de uma função linear.
* Portanto, é natural escolhermos um modelo linear nesse caso. Mas existem vários modelos lineares possíveis, qual escolher?
"

# ╔═╡ c39249ae-94e6-4e9a-8e62-e80572f291f1
md"
---
* Modelo linear que passa pelo primeiro e último pontos do conjunto de dados
"

# ╔═╡ 668f611b-0403-4fd0-a4f1-b88b5e2d7009
begin
	scatter(periodos, medidas, label="Nível de CO2")
	plot!(Shape([(1980, 338.7), (2016, 404.2)]), lc=:red, label=:none)
end

# ╔═╡ 833a64c6-0103-4c63-9709-7c64dce6334f
md"
Neste caso, a equação do nosso modelo linear seria (derivação na lousa):

$$C = 1,819t - 3262,92$$
"

# ╔═╡ 692c4688-0015-41ad-bbcb-98829fcee7a3
md"
---
* Mínimos quadrados ordinários
"

# ╔═╡ b8323367-4c43-4caa-a535-a6f62fe588f2
begin
	ols_co2 = lm(@formula(Y ~ X), nivelco2)
	scatter(periodos, medidas, label="Nível de CO2")
	plot!(periodos, coef(ols_co2)[1] .+ coef(ols_co2)[2] .* periodos, lc=:black, label="Regressão linear (MQO)")
end

# ╔═╡ 3fc2dfae-0f49-4329-a262-8c9697132404
ols_co2

# ╔═╡ 8e87f2ce-6bee-49ce-ab5a-5c2d19ddeb9a
md"""
> **Exercício**.
>
> 1. Use o modelo linear obtido pelo método de MQO para estimar o nível médio de $\text{CO}_2$ em 1987.
>
> 2. Faça uma predição de qual será o nível médio de $\text{CO}_2$ para o ano de 2025.
>
> 3. De acordo com esse modelo, quando o nível de $\text{CO}_2$ excederá 440ppm?
"""

# ╔═╡ 26f35564-38e0-4c13-b4e3-454924a19500
begin
	C1987 = coef(ols_co2)[1] + coef(ols_co2)[2] * 1987
	println("1. O nível médio de CO2 foi de aproximadamente $(round(C1987; digits=2)) ppm no ano de 1987")
end

# ╔═╡ 33b02d16-9d58-4a23-882b-34e507cda401
begin
	C2025 = coef(ols_co2)[1] + coef(ols_co2)[2] * 2025
	println("2. De acordo com nosso modelo linear, prediz-se que o nível médio de CO2 será de aproximadamente $(round(C2025; digits=2)) ppm no ano de 2025")
end

# ╔═╡ bf4e68cd-b2d7-47f1-929b-488b1a018ab2
begin
	res3 = (440 - coef(ols_co2)[1])/coef(ols_co2)[2]
	println("3. De acordo com nosso modelo linear, prediz-se que o nível médio de CO2 ultrapasse 440ppm perto do ano de $(round(Int, res3))")
end

# ╔═╡ eab65645-1cf1-449e-b59a-83fb28601228
md"
### Funções polinomiais

$$f(x) = a_n x^n + a_{n-1}x^{n-1} + \dots + a_2 x^2 + a_1 x + a_0, \qquad n \in \mathbb{Z}_+$$

| $n$ |      Tipo de função      |
|:-----------|-------------:|
| 0  |  constante |
| 1  |    linear  |
| 2 | quadrática |
| 3 | cúbica |
| n | polinomial de grau $n$ |
"

# ╔═╡ 811a8007-3edf-4d7b-aeb7-9aabaf20acc4
begin
	plot(range(-1, 1, 200), x -> 0, lc=:indianred, label="constante")
	plot!(range(-1, 1, 200), x -> x, lc=:pink, label="linear")
	plot!(range(-1, 1, 200), x -> x^2, lc=:black, label="quadrática")
	plot!(range(-1, 1, 200), x -> x^3, lc=:navyblue, label="cúbica")
	plot!(range(-1, 1, 200), x -> x^5, lc=:darkgreen, label="grau 5")
	hline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
	vline!([0], ls=:dash, lw=0.5, lc=:black, label=:none)
end

# ╔═╡ 7c837570-18d7-49a5-bdcf-a28f425e915b
md"""
!!! info "Exemplo"
	Uma bola é solta a partir do posto de observação no topo de uma torre a 450m acima do chão, e sua altura $h$ é registrada em intervalos de 1 segundo na seguinte tabela:

	| Tempo (s) | Altura (m) |
	| :---: | ---: |
	| 0 | 450 |
	| 1 | 445 |
	| 2 | 431 |
	| 3 | 408 |
	| 4 | 375 |
	| 5 | 332 |
	| 6 | 279 |
	| 7 | 216 |
	| 8 | 143 |
	| 9 | 61 |

	Vamos encontrar um modelo para ajustar os dados e utilizá-lo para predizer o tempo após o qual a bola atinge o chão.
"""

# ╔═╡ 5b895096-3d74-49fb-a586-71311403c2d7
begin
	tempo = 0:1:9
	altura = [450, 445, 431, 408, 375, 332, 279, 216, 143, 61]
	modelo_bola = DataFrame(X = tempo, Y = altura)	
	scatter(tempo, altura, label=:none, ms=6, mc=:indianred)	
end

# ╔═╡ 1d86231f-0342-44a5-b59b-bcc40265fca1
md"
* Percebe-se que um modelo linear não é apropriado.
* Aproximaremos os dados por um modelo quadrático da forma:
$$h = at^2 + bt + c$$
"

# ╔═╡ 83dc1a78-1948-4bcb-bcfc-97598a8c40a1
begin
	modelo_quad = lm(@formula(Y ~ X^2 + X), modelo_bola)
	scatter(tempo, altura, mc=:indianred, ms = 6, label="Conjunto de dados")
	plot!(tempo, coef(modelo_quad)[1] .+ coef(modelo_quad)[2] .* tempo.^2 .+ coef(modelo_quad)[3] .* tempo, lc=:black, label="Aproximação quadrática")
end

# ╔═╡ e77dac67-06d6-4c94-8e5c-d04b5c0e86a6
modelo_quad

# ╔═╡ a5d9ac98-1028-4a19-830a-cca51770b57c
md"
### Funções racionais

$$f(x) = \frac{p(x)}{q(x)}$$

onde $p$ e $q$ são funções polinomiais.
"

# ╔═╡ fc906dfc-120a-41c9-a86c-2210963444c0
begin
	plot(range(-5,-2.1,100), x->(2*x^4-x^2+1)/(x^2-4), lc=:indianred, label=:none)
	plot!(range(-1.9,1.9,100), x->(2*x^4-x^2+1)/(x^2-4), lc=:indianred, label=:none)
	plot!(range(2.1,5,100), x->(2*x^4-x^2+1)/(x^2-4), lc=:indianred, label=L"f(x) = \frac{2x^4-x^2+1}{x^2-4}")
	vline!([-2, 2], lc=:black, ls=:dash, lw=0.5, label=:none)
	hline!([0], lc=:black, ls=:dash, lw=0.5, label=:none)
end

# ╔═╡ 3617e9dd-c109-4aba-b6c0-3e57b0362120
md"
### Funções exponenciais

$$f(x) = Ab^x, \qquad b>0$$
"

# ╔═╡ f10ed482-27dd-4bed-b194-139b20d26de5
begin
	l1 = @layout [a b]
	pp1 = plot(range(-5, 5, 100), x -> 2^x, lc=:indianred, label=L"f(x) = 2^x")
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	pp2 = plot(range(-5, 5, 100), x -> 0.5^x, lc=:indianred, label=L"f(x) = (0,5)^x")	
	vline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)
	hline!([0], ls=:dash, lc=:black, lw=0.5, label=:none)	
	plot(pp1, pp2, layout = l1)
end

# ╔═╡ cd2037fe-28c1-4a8e-b177-2f1c2bdfad9a
md"
### Funções logarítmicas
$$f(x) = \log_b x, \qquad b > 0$$
"

# ╔═╡ b19662da-c0c6-42de-9f5b-892661a76e05
begin
	plot(range(0.05, 5, 200), x -> log(2, x), label=L"f(x) = \log_2 x")
	plot!(range(0.05, 5, 200), x -> log(3, x), label=L"f(x) = \log_3 x")
	plot!(range(0.05, 5, 200), x -> log(5, x), label=L"f(x) = \log_5 x")
	plot!(range(0.05, 5, 200), x -> log(10, x), label=L"f(x) = \log_{10} x")
	hline!([0], lc=:black, lw=1, label=:none, ls=:dash)
end

# ╔═╡ f28ab81c-a4df-4a43-8c71-5c1c8a7a3d86
md"
## Propriedades de funções
"

# ╔═╡ 642b4f03-84ea-4da3-a8a9-11e848b403ec
md"""
!!! info "Propriedades de funções"
	Dadas duas funções de valores reais $f$ e $g$, temos:

	| Função | Expressão |
	| :--- | ---: |
	| Soma (diferença) | $(f \pm g)(x) = f(x) \pm g(x)$ |
	| Produto | $(f \cdot g)(x) = f(x) \cdot g(x)$ |
	| Quociente | $(\frac{f}{g})(x) = \frac{f(x)}{g(x)}$ |
	| Mult. por constante | $(c \cdot f)(x) = c \cdot f(x), \quad c \in \mathbb{R}$ |
	| Composta | $(f \circ g)(x) = f(g(x))$ |
"""

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
DataFrames = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
GLM = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Measures = "442fdcdd-2543-5da2-b0f3-8c86c306513e"
Plots = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"

[compat]
DataFrames = "~1.5.0"
GLM = "~1.8.1"
LaTeXStrings = "~1.3.0"
Measures = "~0.3.2"
Plots = "~1.38.6"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.9.2"
manifest_format = "2.0"
project_hash = "fc79403cb30324098e6fbd8661face509c3052ef"

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

[[deps.Calculus]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "f641eb0a4f00c343bbc32346e1217b86f3ce9dad"
uuid = "49dc2e85-a5d0-5ad3-a950-438e2897f1b9"
version = "0.5.1"

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
git-tree-sha1 = "4e88377ae7ebeaf29a047aa1ee40826e0b708a5d"
uuid = "34da2185-b29b-5c13-b0c7-acf172513d20"
version = "4.7.0"
weakdeps = ["Dates", "LinearAlgebra"]

    [deps.Compat.extensions]
    CompatLinearAlgebraExt = "LinearAlgebra"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.0.5+0"

[[deps.ConcurrentUtilities]]
deps = ["Serialization", "Sockets"]
git-tree-sha1 = "96d823b94ba8d187a6d8f0826e731195a74b90e9"
uuid = "f0e56b4a-5159-44fe-b623-3e5288b988bb"
version = "2.2.0"

[[deps.ConstructionBase]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "738fec4d684a9a6ee9598a8bfee305b26831f28c"
uuid = "187b0558-2788-49d3-abe0-74a17ed4e7c9"
version = "1.5.2"

    [deps.ConstructionBase.extensions]
    ConstructionBaseIntervalSetsExt = "IntervalSets"
    ConstructionBaseStaticArraysExt = "StaticArrays"

    [deps.ConstructionBase.weakdeps]
    IntervalSets = "8197267c-284f-5f27-9208-e0e47529a953"
    StaticArrays = "90137ffa-7385-5640-81b9-e52037218182"

[[deps.Contour]]
git-tree-sha1 = "d05d9e7b7aedff4e5b51a029dced05cfb6125781"
uuid = "d38c429a-6771-53c6-b99e-75d170b6e991"
version = "0.6.2"

[[deps.Crayons]]
git-tree-sha1 = "249fe38abf76d48563e2f4556bebd215aa317e15"
uuid = "a8cc5b0e-0ffa-5ad4-8c14-923d3ee1735f"
version = "4.1.1"

[[deps.DataAPI]]
git-tree-sha1 = "8da84edb865b0b5b0100c0666a9bc9a0b71c553c"
uuid = "9a962f9c-6df0-11e9-0e5d-c546b8b5ee8a"
version = "1.15.0"

[[deps.DataFrames]]
deps = ["Compat", "DataAPI", "Future", "InlineStrings", "InvertedIndices", "IteratorInterfaceExtensions", "LinearAlgebra", "Markdown", "Missings", "PooledArrays", "PrettyTables", "Printf", "REPL", "Random", "Reexport", "SentinelArrays", "SnoopPrecompile", "SortingAlgorithms", "Statistics", "TableTraits", "Tables", "Unicode"]
git-tree-sha1 = "aa51303df86f8626a962fccb878430cdb0a97eee"
uuid = "a93c6f00-e57d-5684-b7b6-d8193f3e46c0"
version = "1.5.0"

[[deps.DataStructures]]
deps = ["Compat", "InteractiveUtils", "OrderedCollections"]
git-tree-sha1 = "cf25ccb972fec4e4817764d01c82386ae94f77b4"
uuid = "864edb3b-99cc-5e75-8d2d-829cb0a9cfe8"
version = "0.18.14"

[[deps.DataValueInterfaces]]
git-tree-sha1 = "bfc1187b79289637fa0ef6d4436ebdfe6905cbd6"
uuid = "e2d170a0-9d28-54be-80f0-106bbe20a464"
version = "1.0.0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"

[[deps.DelimitedFiles]]
deps = ["Mmap"]
git-tree-sha1 = "9e2f36d3c96a820c678f2f1f1782582fcf685bae"
uuid = "8bb1440f-4735-579b-a4ab-409b98df4dab"
version = "1.9.1"

[[deps.Distributions]]
deps = ["FillArrays", "LinearAlgebra", "PDMats", "Printf", "QuadGK", "Random", "SparseArrays", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns", "Test"]
git-tree-sha1 = "db40d3aff76ea6a3619fdd15a8c78299221a2394"
uuid = "31c24e10-a181-5473-b8eb-7969acd0382f"
version = "0.25.97"

    [deps.Distributions.extensions]
    DistributionsChainRulesCoreExt = "ChainRulesCore"
    DistributionsDensityInterfaceExt = "DensityInterface"

    [deps.Distributions.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    DensityInterface = "b429d917-457f-4dbc-8f4c-0cc954292b1d"

[[deps.DocStringExtensions]]
deps = ["LibGit2"]
git-tree-sha1 = "2fb1e02f2b635d0845df5d7c167fec4dd739b00d"
uuid = "ffbed154-4ef7-542d-bbb7-c09d3a79fcae"
version = "0.9.3"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.DualNumbers]]
deps = ["Calculus", "NaNMath", "SpecialFunctions"]
git-tree-sha1 = "5837a837389fccf076445fce071c8ddaea35a566"
uuid = "fa6b7ba4-c1ee-5f82-b5fc-ecf0adba8f74"
version = "0.6.8"

[[deps.ExceptionUnwrapping]]
deps = ["Test"]
git-tree-sha1 = "e90caa41f5a86296e014e148ee061bd6c3edec96"
uuid = "460bff9d-24e4-43bc-9d9f-a8973cb893f4"
version = "0.1.9"

[[deps.Expat_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "4558ab818dcceaab612d1bb8c19cee87eda2b83c"
uuid = "2e619515-83b5-522b-bb60-26c02a35a201"
version = "2.5.0+0"

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

[[deps.FillArrays]]
deps = ["LinearAlgebra", "Random", "SparseArrays", "Statistics"]
git-tree-sha1 = "0b3b52afd0f87b0a3f5ada0466352d125c9db458"
uuid = "1a297f60-69ca-5386-bcde-b61e274b549b"
version = "1.2.1"

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

[[deps.Future]]
deps = ["Random"]
uuid = "9fa8497b-333b-5362-9e8d-4d0656e87820"

[[deps.GLFW_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Libglvnd_jll", "Pkg", "Xorg_libXcursor_jll", "Xorg_libXi_jll", "Xorg_libXinerama_jll", "Xorg_libXrandr_jll"]
git-tree-sha1 = "d972031d28c8c8d9d7b41a536ad7bb0c2579caca"
uuid = "0656b61e-2033-5cc2-a64a-77c0f6c09b89"
version = "3.3.8+0"

[[deps.GLM]]
deps = ["Distributions", "LinearAlgebra", "Printf", "Reexport", "SparseArrays", "SpecialFunctions", "Statistics", "StatsAPI", "StatsBase", "StatsFuns", "StatsModels"]
git-tree-sha1 = "97829cfda0df99ddaeaafb5b370d6cab87b7013e"
uuid = "38e38edf-8417-5370-95a0-9cbb8c7f171a"
version = "1.8.3"

[[deps.GR]]
deps = ["Artifacts", "Base64", "DelimitedFiles", "Downloads", "GR_jll", "HTTP", "JSON", "Libdl", "LinearAlgebra", "Pkg", "Preferences", "Printf", "Random", "Serialization", "Sockets", "TOML", "Tar", "Test", "UUIDs", "p7zip_jll"]
git-tree-sha1 = "8b8a2fd4536ece6e554168c21860b6820a8a83db"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.72.7"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "19fad9cd9ae44847fe842558a744748084a722d1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.72.7+0"

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
deps = ["Base64", "CodecZlib", "ConcurrentUtilities", "Dates", "ExceptionUnwrapping", "Logging", "LoggingExtras", "MbedTLS", "NetworkOptions", "OpenSSL", "Random", "SimpleBufferStream", "Sockets", "URIs", "UUIDs"]
git-tree-sha1 = "7f5ef966a02a8fdf3df2ca03108a88447cb3c6f0"
uuid = "cd3eb016-35fb-5094-929b-558a96fad6f3"
version = "1.9.8"

[[deps.HarfBuzz_jll]]
deps = ["Artifacts", "Cairo_jll", "Fontconfig_jll", "FreeType2_jll", "Glib_jll", "Graphite2_jll", "JLLWrappers", "Libdl", "Libffi_jll", "Pkg"]
git-tree-sha1 = "129acf094d168394e80ee1dc4bc06ec835e510a3"
uuid = "2e76f6c2-a576-52d4-95c1-20adfe4de566"
version = "2.8.1+1"

[[deps.HypergeometricFunctions]]
deps = ["DualNumbers", "LinearAlgebra", "OpenLibm_jll", "SpecialFunctions"]
git-tree-sha1 = "0ec02c648befc2f94156eaef13b0f38106212f3f"
uuid = "34004b35-14d8-5ef3-9330-4cdb6864b03a"
version = "0.3.17"

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

[[deps.InlineStrings]]
deps = ["Parsers"]
git-tree-sha1 = "9cc2baf75c6d09f9da536ddf58eb2f29dedaf461"
uuid = "842dd82b-1e85-43dc-bf29-5d0ee9dffc48"
version = "1.4.0"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"

[[deps.InvertedIndices]]
git-tree-sha1 = "0dc7b50b8d436461be01300fd8cd45aa0274b038"
uuid = "41ab1584-1d38-5bbf-9106-f11c6c58b48f"
version = "1.3.0"

[[deps.IrrationalConstants]]
git-tree-sha1 = "630b497eafcc20001bba38a4651b327dcfc491d2"
uuid = "92d709cd-6900-40b7-9082-c6be49f344b6"
version = "0.2.2"

[[deps.IteratorInterfaceExtensions]]
git-tree-sha1 = "a3f24677c21f5bbe9d2a714f95dcd58337fb2856"
uuid = "82899510-4779-5014-852e-03e436cf321d"
version = "1.0.0"

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

[[deps.LLVMOpenMP_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "f689897ccbe049adb19a065c495e75f372ecd42b"
uuid = "1d63c593-3942-5779-bab2-d838dc0a180e"
version = "15.0.4+0"

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
git-tree-sha1 = "f428ae552340899a935973270b8d98e5a31c49fe"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.16.1"

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
git-tree-sha1 = "c3ce8e7420b3a6e071e0fe4745f5d4300e37b13f"
uuid = "2ab3a3ac-af41-5b50-aa03-7779005ae688"
version = "0.3.24"

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
deps = ["Artifacts", "JLLWrappers", "Libdl"]
git-tree-sha1 = "1aa4b74f80b01c6bc2b89992b861b5f210e665b5"
uuid = "458c3c95-2e84-50aa-8efc-19380b2a3a95"
version = "1.1.21+0"

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

[[deps.PDMats]]
deps = ["LinearAlgebra", "SparseArrays", "SuiteSparse"]
git-tree-sha1 = "67eae2738d63117a196f497d7db789821bce61d1"
uuid = "90014a1f-27ba-587c-ab20-58faa44d9150"
version = "0.11.17"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "4b2e829ee66d4218e0cef22c0a64ee37cf258c29"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.7.1"

[[deps.Pipe]]
git-tree-sha1 = "6842804e7867b115ca9de748a0cf6b364523c16d"
uuid = "b98c9c47-44ae-5843-9183-064241ee97a0"
version = "1.3.0"

[[deps.Pixman_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "JLLWrappers", "LLVMOpenMP_jll", "Libdl"]
git-tree-sha1 = "64779bc4c9784fee475689a1752ef4d5747c5e87"
uuid = "30392449-352a-5448-841d-b1acce4e97dc"
version = "0.42.2+0"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "REPL", "Random", "SHA", "Serialization", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.9.2"

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
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "PrecompileTools", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "UnitfulLatexify", "Unzip"]
git-tree-sha1 = "75ca67b2c6512ad2d0c767a7cfc55e75075f8bbc"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.16"

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

[[deps.PooledArrays]]
deps = ["DataAPI", "Future"]
git-tree-sha1 = "a6062fe4063cdafe78f4a0a81cfffb89721b30e7"
uuid = "2dfb63ee-cc39-5dd5-95bd-886bf059d720"
version = "1.4.2"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "9673d39decc5feece56ef3940e5dafba15ba0f81"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.1.2"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "7eb1686b4f04b82f96ed7a4ea5890a4f0c7a09f1"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.0"

[[deps.PrettyTables]]
deps = ["Crayons", "Formatting", "LaTeXStrings", "Markdown", "Reexport", "StringManipulation", "Tables"]
git-tree-sha1 = "213579618ec1f42dea7dd637a42785a608b1ea9c"
uuid = "08abe8d2-0d0c-5749-adfa-8a2ac140af0d"
version = "2.2.4"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"

[[deps.Qt5Base_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Fontconfig_jll", "Glib_jll", "JLLWrappers", "Libdl", "Libglvnd_jll", "OpenSSL_jll", "Pkg", "Xorg_libXext_jll", "Xorg_libxcb_jll", "Xorg_xcb_util_image_jll", "Xorg_xcb_util_keysyms_jll", "Xorg_xcb_util_renderutil_jll", "Xorg_xcb_util_wm_jll", "Zlib_jll", "xkbcommon_jll"]
git-tree-sha1 = "0c03844e2231e12fda4d0086fd7cbe4098ee8dc5"
uuid = "ea2cea3b-5b76-57ae-a6ef-0a8af62496e1"
version = "5.15.3+2"

[[deps.QuadGK]]
deps = ["DataStructures", "LinearAlgebra"]
git-tree-sha1 = "6ec7ac8412e83d57e313393220879ede1740f9ee"
uuid = "1fd47b50-473d-5c70-9696-f719f8f3bcdc"
version = "2.8.2"

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

[[deps.Rmath]]
deps = ["Random", "Rmath_jll"]
git-tree-sha1 = "f65dcb5fa46aee0cf9ed6274ccbd597adc49aa7b"
uuid = "79098fc4-a85e-5d69-aa6a-4863f24498fa"
version = "0.7.1"

[[deps.Rmath_jll]]
deps = ["Artifacts", "JLLWrappers", "Libdl", "Pkg"]
git-tree-sha1 = "6ed52fdd3382cf21947b15e8870ac0ddbff736da"
uuid = "f50d1b31-88e8-58de-be2c-1cc44531875f"
version = "0.4.0+0"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Scratch]]
deps = ["Dates"]
git-tree-sha1 = "30449ee12237627992a99d5e30ae63e4d78cd24a"
uuid = "6c6a2e73-6563-6170-7368-637461726353"
version = "1.2.0"

[[deps.SentinelArrays]]
deps = ["Dates", "Random"]
git-tree-sha1 = "04bdff0b09c65ff3e06a05e3eb7b120223da3d39"
uuid = "91c51154-3ec4-41a3-a24f-3f23e20d615c"
version = "1.4.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"

[[deps.ShiftedArrays]]
git-tree-sha1 = "503688b59397b3307443af35cd953a13e8005c16"
uuid = "1277b4bf-5013-50f5-be3d-901d8477a67a"
version = "2.0.0"

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
git-tree-sha1 = "c60ec5c62180f27efea3ba2908480f8055e17cee"
uuid = "a2af1166-a08f-5f64-846c-94a0d3cef48c"
version = "1.1.1"

[[deps.SparseArrays]]
deps = ["Libdl", "LinearAlgebra", "Random", "Serialization", "SuiteSparse_jll"]
uuid = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.SpecialFunctions]]
deps = ["IrrationalConstants", "LogExpFunctions", "OpenLibm_jll", "OpenSpecFun_jll"]
git-tree-sha1 = "7beb031cf8145577fbccacd94b8a8f4ce78428d3"
uuid = "276daf66-3868-5448-9aa4-cd146d93841b"
version = "2.3.0"

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
git-tree-sha1 = "75ebe04c5bed70b91614d684259b661c9e6274a4"
uuid = "2913bbd2-ae8a-5f71-8c99-4fb6c76f3a91"
version = "0.34.0"

[[deps.StatsFuns]]
deps = ["HypergeometricFunctions", "IrrationalConstants", "LogExpFunctions", "Reexport", "Rmath", "SpecialFunctions"]
git-tree-sha1 = "f625d686d5a88bcd2b15cd81f18f98186fdc0c9a"
uuid = "4c63d2b9-4356-54db-8cca-17b64c39e42c"
version = "1.3.0"

    [deps.StatsFuns.extensions]
    StatsFunsChainRulesCoreExt = "ChainRulesCore"
    StatsFunsInverseFunctionsExt = "InverseFunctions"

    [deps.StatsFuns.weakdeps]
    ChainRulesCore = "d360d2e6-b24c-11e9-a2a3-2a2ae2dbcce4"
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.StatsModels]]
deps = ["DataAPI", "DataStructures", "LinearAlgebra", "Printf", "REPL", "ShiftedArrays", "SparseArrays", "StatsBase", "StatsFuns", "Tables"]
git-tree-sha1 = "8cc7a5385ecaa420f0b3426f9b0135d0df0638ed"
uuid = "3eaba693-59b7-5ba5-a881-562e759f1c8d"
version = "0.7.2"

[[deps.StringManipulation]]
git-tree-sha1 = "46da2434b41f41ac3594ee9816ce5541c6096123"
uuid = "892a3eda-7b42-436c-8928-eab12a02cf0e"
version = "0.3.0"

[[deps.SuiteSparse]]
deps = ["Libdl", "LinearAlgebra", "Serialization", "SparseArrays"]
uuid = "4607b0f0-06f3-5cda-b6b1-a6196a1729e9"

[[deps.SuiteSparse_jll]]
deps = ["Artifacts", "Libdl", "Pkg", "libblastrampoline_jll"]
uuid = "bea87d4a-7f5b-5778-9afe-8cc45184846c"
version = "5.10.1+6"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.TableTraits]]
deps = ["IteratorInterfaceExtensions"]
git-tree-sha1 = "c06b2f539df1c6efa794486abfb6ed2022561a39"
uuid = "3783bdb8-4a98-5b6b-af9a-565f29a5fe9c"
version = "1.0.1"

[[deps.Tables]]
deps = ["DataAPI", "DataValueInterfaces", "IteratorInterfaceExtensions", "LinearAlgebra", "OrderedCollections", "TableTraits", "Test"]
git-tree-sha1 = "1544b926975372da01227b382066ab70e574a3ec"
uuid = "bd369af6-aec1-5ad0-b16a-f7cc5008161c"
version = "1.10.1"

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

[[deps.Unitful]]
deps = ["ConstructionBase", "Dates", "LinearAlgebra", "Random"]
git-tree-sha1 = "ba4aa36b2d5c98d6ed1f149da916b3ba46527b2b"
uuid = "1986cc42-f94f-5a68-af5c-568840ba703d"
version = "1.14.0"

    [deps.Unitful.extensions]
    InverseFunctionsUnitfulExt = "InverseFunctions"

    [deps.Unitful.weakdeps]
    InverseFunctions = "3587e190-3f89-42d0-90ee-14403ec27112"

[[deps.UnitfulLatexify]]
deps = ["LaTeXStrings", "Latexify", "Unitful"]
git-tree-sha1 = "e2d817cc500e960fdbafcf988ac8436ba3208bfd"
uuid = "45397f5d-5981-4c77-b2b3-fc36d6e9b728"
version = "1.6.3"

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
version = "5.8.0+0"

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
# ╟─8a03f030-bda9-11ed-35ca-d1e52878d401
# ╟─093eb733-6578-4b97-b04f-ca1c796ceea8
# ╟─de3cdefd-e381-4046-80f9-7b542b1b7c7d
# ╟─01314865-c37a-4f0c-8081-2eedc6968ec2
# ╟─0f908f8c-a8e5-4a45-a551-c92db81b05c8
# ╟─9bb79ac7-b24b-4e46-b9f8-0fb248cab1fb
# ╟─79a3afd4-4f05-4501-a269-694820f35feb
# ╟─35ae248e-e8d2-4c8c-8731-8bfe7fcf29f2
# ╟─a80986af-ef58-4704-b464-78a8ef2c0b67
# ╟─77172b5f-7cbb-4056-a876-f5c1a59e16e2
# ╟─31a5a354-04dc-44de-8a5d-fae8f5458f2c
# ╟─b5da0f74-1bec-41af-8f38-3c82713bbec3
# ╟─49f4736a-1115-4e37-abd6-906ca0621d37
# ╟─dce4b713-f0c0-422b-9739-7c83a4750a8d
# ╟─16ea9617-126a-484e-bb26-efd1b03f99c6
# ╟─151c7c52-fe14-4774-996a-5d42dca4fd1c
# ╟─a5d93ca6-f24d-48ac-a30c-6ef21efdfe4a
# ╟─714632a2-8035-46e1-a9dc-6b0206150cb7
# ╟─79243ee6-95a9-41cb-8258-2ceee8d56d36
# ╟─60046e4b-ac01-429c-8481-d7bd776744c9
# ╟─d933f5aa-b214-4c5f-ba5e-797e6ec5a648
# ╟─154dbf13-4586-4721-adf1-e0920c2799ed
# ╟─2d5f24e4-92f6-4c68-8c09-6d4ad92c5c69
# ╟─292ee2c9-5f36-4a0d-9548-f0bcada8e9d5
# ╟─652fd098-dcfc-49e2-b4a2-8c2789f775d1
# ╟─5d66531b-ef38-4d57-bdc3-c5277d5fb0a1
# ╟─6ad44887-a910-4e1a-a700-fd6eda342299
# ╟─ab3c6cd9-0e05-4dda-b3ce-76afc1f4fcf1
# ╟─875a957f-aeb3-4cd3-9cd0-ab5ed075eb47
# ╟─ff813602-eb49-4d6b-87e5-48a5923ce37a
# ╟─6358a6f0-d7cd-40e7-a067-c570bef940f5
# ╟─d0a26769-1a72-4f46-a1ce-79c2b7a6547b
# ╟─8792d2d4-963b-41e8-8889-f28efef53af8
# ╟─1b57ca0f-0046-4bdb-b6ae-33bd5148e023
# ╟─aa71d767-ef6c-4edb-95cc-58d723c1e9f7
# ╟─2be64749-c1f6-4d92-ad94-b286e30bff36
# ╟─fe8e8811-5133-4a85-b67a-6b9cec0fdbb2
# ╟─f974b3eb-ef26-4083-ba15-dc4db1be1c00
# ╟─d1dcf742-6a69-4808-8f3d-05b13ba852ae
# ╟─b8479ad6-7895-4c28-88aa-3eb390307795
# ╟─d009f5ad-8c87-48c7-a110-ce840bdcb4ff
# ╟─e06b7eda-7036-484e-83ed-243618cb487d
# ╟─8125c626-a72c-42b9-8544-b923494b0b67
# ╟─64a6c014-7756-40c9-833f-4b3522755714
# ╟─82ab9b17-dc93-406e-8288-2a2bd43e5e9a
# ╟─c39249ae-94e6-4e9a-8e62-e80572f291f1
# ╟─668f611b-0403-4fd0-a4f1-b88b5e2d7009
# ╟─833a64c6-0103-4c63-9709-7c64dce6334f
# ╟─692c4688-0015-41ad-bbcb-98829fcee7a3
# ╟─b8323367-4c43-4caa-a535-a6f62fe588f2
# ╟─3fc2dfae-0f49-4329-a262-8c9697132404
# ╟─8e87f2ce-6bee-49ce-ab5a-5c2d19ddeb9a
# ╟─26f35564-38e0-4c13-b4e3-454924a19500
# ╟─33b02d16-9d58-4a23-882b-34e507cda401
# ╟─bf4e68cd-b2d7-47f1-929b-488b1a018ab2
# ╟─eab65645-1cf1-449e-b59a-83fb28601228
# ╟─811a8007-3edf-4d7b-aeb7-9aabaf20acc4
# ╟─7c837570-18d7-49a5-bdcf-a28f425e915b
# ╟─5b895096-3d74-49fb-a586-71311403c2d7
# ╟─1d86231f-0342-44a5-b59b-bcc40265fca1
# ╠═e77dac67-06d6-4c94-8e5c-d04b5c0e86a6
# ╟─83dc1a78-1948-4bcb-bcfc-97598a8c40a1
# ╟─a5d9ac98-1028-4a19-830a-cca51770b57c
# ╟─fc906dfc-120a-41c9-a86c-2210963444c0
# ╟─3617e9dd-c109-4aba-b6c0-3e57b0362120
# ╟─f10ed482-27dd-4bed-b194-139b20d26de5
# ╟─cd2037fe-28c1-4a8e-b177-2f1c2bdfad9a
# ╟─b19662da-c0c6-42de-9f5b-892661a76e05
# ╟─f28ab81c-a4df-4a43-8c71-5c1c8a7a3d86
# ╟─642b4f03-84ea-4da3-a8a9-11e848b403ec
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
