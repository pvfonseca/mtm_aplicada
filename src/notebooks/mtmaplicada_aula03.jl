### A Pluto.jl notebook ###
# v0.19.22

using Markdown
using InteractiveUtils

# ╔═╡ 64369800-d1a2-11ed-04da-9712268f297f
begin
	using PlutoUI
	using Plots
	using LaTeXStrings
	using Measures	
	theme(:ggplot2)
	gr(size=(800,600), lw = 2, fontfamily = "Computer Modern", grid=true, tickfontsize = 12, guidefontsize=16, framestyle=:box, margin=3mm, right_margin=7mm, guidefonthalign=:right, guidefontvalign=:top)	
end

# ╔═╡ cdf12936-b45d-4f5c-a954-87c743c6d083
PlutoUI.TableOfContents(title="Sumário", indent=true)

# ╔═╡ c72aacad-3f25-4d82-9cd3-89a1d09ef5a2
html"<button onclick=present()>Apresentação</button>"

# ╔═╡ 4fe2b3ea-6834-4ec4-8123-1c57c76f9c4e
md"""
# Limites $~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~$ $(Resource("https://www1.udesc.br/imagens/id_submenu/899/cor_horizontal_rgb.jpg", :width => 150))
"""

# ╔═╡ b1eb2efd-7b25-4db3-84c4-d395d2525726
md"
* **Disciplina:** 11MTMAP - Matemática Aplicada
* **Data:** 03/04/2023
* **Docente:** [Paulo Victor da Fonseca](https://pvfonseca.github.io)
* **Contato:** [paulo.fonseca@udesc.br](mailto:paulo.fonseca@udesc.br)
"

# ╔═╡ e32edb79-90c1-4f7c-8784-655517671227
md"""
!!! danger "Aviso"
	O texto que segue não tem a menor pretensão de originalidade. Ele serve apenas como registro dos principais princípios, conceitos e técnicas analíticas que são trabalhados em sala de aula.	

	▶️ **Leitura obrigatória**: Stewart, Clegg, Watson (2022) - [Cálculo: volume I](https://app.minhabiblioteca.com.br/reader/books/9786555584097): Seções 2.1 a 2.3
"""

# ╔═╡ 1c98c97d-4205-4125-8366-517ac9170445
md"
## Limite de uma função
"

# ╔═╡ d83df195-f950-4ff1-99f0-355a2ec3371e
md"
* O conceito de **limite** é, certamente, o mais importante e, provavelmente, o mais difícil em cálculo
* O objetivo desta aula é fornecer uma definição _informal_ de limites
* O que definiremos não é a palavra ''limite'' mas, sim, a noção de uma função se aproximando de um limite
"

# ╔═╡ f7f299f3-6466-468a-8efb-5e866cea87c9
md"
### Abordagem gráfica e numérica
"

# ╔═╡ b24f8989-5849-4398-9da4-abb56a81ab58
begin
	f(x) = (x-1)/(x^2-1)
	plot(range(-0.5, 4, 100), x->f(x), lc=:indianred, label=L"f(x)=\frac{x-1}{x^2-1}")
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)
	scatter!([(1, 0.5)], label=:none, m = (6, :white, stroke(1, :indianred)))
end

# ╔═╡ 9f3870f1-3ced-42f7-aa46-c733ee70619f
md"
* Considere a função univariada de valores reais
$$f(x) = \frac{x-1}{x^2-1}$$
* Analisaremos seu comportamento para valores de $x$ que se aproximam de 1
| $x<1$ | $f(x)$ | $x>1$ | $f(x)$ |
| :--- | :--- | :--- | :--- |
| 0.5 | $(round(f(0.5); digits= 6)) | 1.5 | $(round(f(1.5); digits= 6)) |
| 0.9 | $(round(f(0.9); digits= 6)) | 1.1 | $(round(f(1.1); digits= 6)) |
| 0.99 | $(round(f(0.99); digits= 6)) | 1.01 | $(round(f(1.01); digits= 6)) |
| 0.999 | $(round(f(0.999); digits= 6)) | 1.001 | $(round(f(1.001); digits= 6)) |
| 0.9999 | $(round(f(0.9999); digits= 6)) | 1.0001 | $(round(f(1.0001); digits= 6)) |
"

# ╔═╡ feb72847-f56c-4e46-be25-0f6e7532f464
md"
* Pela tabela e pelo gráfico da função, notamos que quanto mais próximo $x$ estiver de 1 (de qualquer lado de 1), mais próximo $f(x)$ estará de 0,5
* Podemos tornar os valores de $f(x)$ tão próximos de 0,5 quanto quisermos, ao tornar $x$ suficientemente próximo de 1
* Este fato pode ser expresso pela seguinte afirmação ''o limite da função $f(x) = \frac{x-1}{x^2-1}$ quando $x$ tende a 1 é igual a 0,5''
* A afirmação anterior pode ser representada pela seguinte notação:
$$\lim_{x\to 1} \frac{x-1}{x^2-1} = 0,5$$
"

# ╔═╡ 3f44eb1d-5eac-43f9-83ee-3d1402cfb769
md"""
!!! correct "Definição (informal) 3.1 - Limite de uma função"
	Suponha que $f(x)$ seja definido em algum intervalo aberto que contenha $a$, exceto possivelmente no próprio $a$. Então:

	$$\lim_{x \to a} f(x) = L\tag{1}\label{eq1}$$
	
	se pudermos tornar os valores de $f(x)$ arbitrariamente próximos de $L$ ao tornar $x$ suficientemente próximo de $a$, mas não igual a $a$.

	A expressão ($\ref{eq1}$) é lida como ''o limite de $f(x)$, quando $x$ tende a $a$, é igual a $L$''.
"""

# ╔═╡ 36c377fc-f76b-49db-986f-7cb0b0829fee
md"""
!!! warning "Definição formal de limite"
	A definição do limite de uma função apenas apresentada é uma definição intuitiva.

	A definição formal pode ser enunciada da seguinte forma:

	Seja $f$ uma função definida em algum intervalo aberto que contenha o número $a$, exceto possivelmente no próprio $a$. Dizemos que o limite de $f(x)$ quando $x$ tende a $a$ é $L$ se para qualquer número $\varepsilon > 0$, houver um número $\delta > 0$ tal que:

	$$\text{se } 0<|x-a|<\delta, \text{ então } |f(x) - L|<\varepsilon$$

	Para o propósito da evolução da disciplina, o conceito intuitivo de limite de uma função que apresentamos anteriormente será suficiente.

	Para o aluno interessado na definição formal, consultar:

	Stewart, Clegg, Watson - [Cálculo: volume I (2022)](https://app.minhabiblioteca.com.br/reader/books/9786555584097) - seção 2.4

	Spivak - Calculus (1994) - cap. 5
"""

# ╔═╡ 41706370-645c-4a89-a9b8-15c25bcb18cd
md"
* Observe que escrevemos na nossa definição ''mas $x$ não é igual a $a$''
* Isso significa que, ao procurar o limite de $f(x)$ quando $x$ tende a $a$, nunca consideramos $x = a$
*  $f(x)$ nem precisa estar definido quando $x = a$
* A única coisa que importa é como a função $f$ está definida na _vizinhança do ponto $a$_
"

# ╔═╡ ad81f15f-f88e-425e-8f42-1dd419ff6122
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig1.PNG", :width => 800))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ af1bf46c-80cd-4daa-803a-7e0935a6872a
md"
* A figura acima mostra os gráficos de três funções
* Note que, na figura (b), $f(a)$ não está definida
* Na figura (c), $f(a) \neq L$
* Mas, ainda assim, nos três casos, temos que $\lim_{x \to a} f(x) = L$
"

# ╔═╡ 6a294008-f2d6-43e4-b498-a83476716b4e
begin
	g(x) = (√(x^2+9)-3)/x^2
	plot(range(-2, 2, 100), x->g(x), lc=:indianred, label=L"g(t)=\frac{\sqrt{t^2+9}-3}{t^2}")
	vline!([0], lc=:black, lw=1, label=:none)
	ylims!(0.15,0.17)
	scatter!([(0, 1/6)], label=:none, m = (6, :white, stroke(1, :indianred)))
end

# ╔═╡ 2629065b-eddc-4929-8293-73666f637c45
md"
---
* Considere, agora, a seguinte função:
$$g(t) = \frac{\sqrt{t^2+9}-2}{t^2}$$
* Vamos analisar o comportamento desta função quando $t$ se aproxima de 0
| $t$ | $g(t)$ |
| :--- | :--- |
| $\pm 1.0$ | $(round(g(1.0); digits= 6)) |
| $\pm 0.5$ | $(round(g(0.5); digits= 6)) |
| $\pm 0.1$ | $(round(g(0.1); digits= 6)) |
| $\pm 0.05$ | $(round(g(0.05); digits= 6)) |
| $\pm 0.01$ | $(round(g(0.01); digits= 6)) |
"

# ╔═╡ 7d2bedcb-a38e-47bf-9de3-957519de7803
md"
* À medida que $t$ tende a 0, os valores da função parecem a tender a $0,166666\dots$
* Assim, podemos conjecturar que
$$\lim_{t\to 0}\frac{\sqrt{t^2+9}-3}{t^2} = \frac{1}{6}$$
"

# ╔═╡ 66e456f0-68a9-4eaa-b40c-072a5e3c5bc1
md"
---
### Limites laterais
"

# ╔═╡ 0f9288cf-6c68-47ce-96bb-e0bb91ca02b4
md"
* A função de Heaviside, $H$, é definida por:
$$H(t) = \begin{cases}0, & \text{se } t<0\\ 1, &\text{se } t\geq 0\end{cases}$$
* O gráfico desta função está representado abaixo
"

# ╔═╡ a539b60f-e122-4e30-bc55-020549602dcf
begin	
	plot(range(-4, 0, 100), x->0, lc=:indianred, label=:none)		
	plot!(range(0, 4, 100), x->1, lc=:indianred, label=:none)
	vline!([0], lc=:black, lw=0.3, label=:none)
	hline!([0], lc=:black, lw=0.3, label=:none)
	ylims!(-0.5, 1.5)
	scatter!([(0, 0)], label=:none, m = (6, :white, stroke(1, :indianred)))
	scatter!([(0, 1)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
end

# ╔═╡ ba3aa560-ef9a-44a8-bfdb-cb45c5e21ec6
md"
* Note que não há um único número para o qual $H(t)$ tende quando $t \to 0$
* Portanto, o $\lim_{t\to 0} H(t)$ não existe
* No entanto, quando $t$ tende a 0 pela esquerda, $H(t)$ tende a 0
* De maneira análoga, quando $t$ tende a 0 pela direita, $H(t)$ tende a 1
* Formalmente, denotamos estes fatos usando a seguinte notação:
$$\begin{eqnarray}\lim_{t\to 0^{-}} H(t) &=& 0\\ \lim_{t\to 0^{+}} H(t) &=& 1\end{eqnarray}$$
* Denominamos esses limites de **limites laterais**
* A notação $t\to 0^{-}$ indica que estamos considerando apenas valores de $t$ menores que 0
* Analogamente, $t\to 0^{+}$ indica que estamos considerando apenas valores de $t$ maiores que 0
"

# ╔═╡ e078bb2f-1b59-4c66-b293-72c39de4c8d2
md"""
!!! warning "Função de Heaviside"
	A [**`função de Heaviside`**](https://en.wikipedia.org/wiki/Heaviside_step_function), ou função degrau de Heaviside, usualmente denotada por $H$ ou $\Theta$ é uma função degrau nomeada em homenagem ao matemático e engenheiro eletricista Oliver Heaviside (1850-1925).

	Esta função pode ser usada para descrever uma corrente elétrica que é ligada em $t = 0$.
"""

# ╔═╡ dc3ef891-439f-42df-9465-7cff9480eebf
md"""
$(Resource("https://upload.wikimedia.org/wikipedia/commons/8/8a/Oliver_Heaviside2.jpg", :width=>300))
[Oliver Heaviside (1850-1925)](https://en.wikipedia.org/wiki/Oliver_Heaviside)
"""

# ╔═╡ c05b2971-99cc-49c5-a669-fe215478eaee
md"""
!!! correct "Definição 3.2 - Limites laterais"
	Dizemos que o **limite à esquerda** de $f(x)$ quando $x$ tende a $a$ (ou o limite de $f(x)$ quando $x$ tende a $a$ pela esquerda) é igual a $L$ se pudermos tornar os valores de $f(x)$ arbitrariamente próximos de $L$, ao restringirmos $x$ a uma região suficientemente pequena em torno de $a$, com $x<a$:

	$$\lim_{x\to a^{-}} f(x) = L \tag{2}$$

	De maneira análoga, podemos definir o **limite à direita** de $f(x)$, denotado por $\lim_{x\to a^{+}} f(x)$ [fazendo $f(x)$ se aproximar arbitrariamente de $L$ quando restringimos $x$ a uma vizinhança de $a$, com $x>a$].
"""

# ╔═╡ 8c66187e-39c7-4144-83eb-71ad96ab0ba3
md"""
!!! info "Afirmação 3.1"
	$$\lim_{x\to a} f(x) = L \quad \text{ se, e somente se, } \lim_{x\to a^{-}} f(x) = L \text{ e } \lim_{x\to a^{+}} f(x) = L.$$
"""

# ╔═╡ 164d3d9a-c0ca-4c5c-9a93-2aa1ead66bfc
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig2.PNG", :width => 800))
Fonte: Spivak (1994) - Calculus
"""

# ╔═╡ f8c02a07-ccb6-4c2f-a5d8-9783b4843634
md"
* Considerando as definições de limites laterais e a afirmação 3.1, percebemos que das seis funções representadas na figura acima, apenas as três primeiras aproximam-se de $l$ em $a$
"

# ╔═╡ bbf34216-9e7c-4701-9bd4-191e3836c5dc
md"""
> **Exercício**
>
> Considere o gráfico da função $g$ abaixo
>
> Determine os valores (se existirem) dos seguintes limites:
>
> (a) $\lim_{x\to 2^{-}} g(x)$
>
> (b) $\lim_{x\to 2^{+}} g(x)$
>
> (c) $\lim_{x\to 2} g(x)$
>
> (d) $\lim_{x\to 5^{-}} g(x)$
>
> (e) $\lim_{x\to 5^{+}} g(x)$
>
> (f) $\lim_{x\to 5} g(x)$

$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig3.PNG", :width => 800))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ 5bb03821-eeb9-47f5-85dd-81b7b8b06ec9
md"
---
### Não-existência do limite de uma função 
"

# ╔═╡ 021a60e0-2b89-4833-b34f-1d5d3856327b
md"
* O exercício anterior, e a afirmação 3.1, evidenciam o caso em que o limite de uma função não existe quando $x$ tende a um número $a$
* Neste caso, os limites à esquerda e à direita são diferentes
* Veremos, agora, outras situações em que um limite pode não existir
"

# ╔═╡ 29764604-0719-4411-a1d5-b7e51c46225b
md"
$....................................................................................$
* Analisaremos o comportamento da função $s(x)$ quando $x$ tende a 0, sendo $s(x)$ definida por:
$$s(x) = \text{sen } \frac{\pi}{x}$$
* Note que a função $s(x)$ não está definida para $x = 0$
* Faremos uma avaliação da função para valores de $x$ que aproximam-se de 0
| $x$ | $s(x)$ |
| :--- | :--- |
| $1$ | 0 |
| $\frac{1}{2}$ | 0 |
| $\frac{1}{3}$ | 0 |
| $\frac{1}{4}$ | 0 |
| $0.1$ | 0 |
| $0.01$ | 0 |
| $0.001$ | 0 |
| $0.0001$ | 0 |
"

# ╔═╡ 83d13128-8917-4d86-a4c9-7088f2a1eac2
md"
* Com base na tabela fornecida acima, somos tentados a concluir que o limite da função $s(x)$ quando $x$ tende a zero é igual a 0
    
  ⚠️ No entanto, essa suposição está errada❗❗

* Observe que, embora $f(1/n) = \text{sen } n\pi = 0$, para todo número inteiro $n$, também é verdade que $f(x) = 1$ para um número infinito de valores de $x$ (como 2/5 e 2/101) que tendem a 0
* Ver gráfico da função abaixo
"

# ╔═╡ 5db4adc7-a879-48a4-aced-5ddadd6085c2
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig4.PNG", :width => 800))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ f70a2010-faad-4677-9987-649d9c1a869d
md"
* Note que os valores da função oscilam com frequência infinita entre 1 e -1 quando $x$ tende a 0
* Uma vez que os valores de $f(x)$ não tendem a um número fixo quando $x$ tende a 0, concluímos que:
$$\nexists \lim_{x\to 0} \text{sen } \frac{\pi}{x}$$
"

# ╔═╡ 60862767-63d4-4b9b-a665-d982dc936009
begin	
	u(x) = 1/x^2
	plot(range(-1, 0, 50), x->u(x), lc=:indianred, label=:none)			
	plot!(range(0, 1, 50), x->u(x), lc=:indianred, label=:none)			
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)		
end

# ╔═╡ 9cb382f3-7da6-45f7-9c2e-26728c79d831
md"
$....................................................................................$

* Consideraremos, agora, uma situação na qual o limite em um número $a$ não existe pois os valores da função crescem de forma arbitrária (em valor absoluto) quando $x$ tende a $a$
* Seja $u(x)$ uma função definida por:
$$u(x) = \frac{1}{x^2}$$
* Qual o comportamento da função $u$ quando $x$ tende a 0?
| $x$ | $u(x) = \frac{1}{x^2}$ |
| :--- | ---: |
| $\pm 1$ | $(round(Int, u(1))) |
| $\pm 0.5$ | $(round(Int, u(0.5))) |
| $\pm 0.2$ | $(round(Int, u(0.2))) |
| $\pm 0.1$ | $(round(Int, u(0.1))) |
| $\pm 0.05$ | $(round(Int, u(0.05))) |
| $\pm 0.01$ | $(round(Int, u(0.01))) |
| $\pm 0.001$ | $(round(Int, u(0.001))) |
"

# ╔═╡ c6ecb81a-1512-48bd-a994-13acb14c44ab
md"
* Note que à medida que $x$ tende à 0, $x^2$ também tende a 0 e, portanto, $1/x^2$ fica muito grande
* Pelo gráfico da função percebemos que $f(x)$ pode se tornar arbitrariamente grande ao tornarmos os valores de $x$ suficientemente próximos de 0
* Assim, os valores de $f(x)$ não tendem a um número e, portanto, $\nexists \lim_{x\to 0} \frac{1}{x^2}$
* Neste caso, temos um limite infinito que denotamos por:
$$\lim_{x\to 0} \frac{1}{x^2} = \infty$$

  ⚠️ Isso não significa que consideramos $\infty$ um número, nem que o limite existe!

* Temos, simplesmente, uma notação para expressar, de maneira particular, que o limite não existe e a função torna-se arbitrariamente grande quando fazemos $x$ aproximar-se de maneira suficiente de 0
"

# ╔═╡ e8f9eab2-08c9-4621-b9c0-2af77fc88281
md"
---
### Limites infinitos e assíntotas verticais
"

# ╔═╡ 2e6e1911-b5a7-4fd2-b43f-fcc5e0c8f195
md"
* Em geral, indicamos que os valores de $f(x)$ tendem a se tornar cada vez maiores (ou a crescer ilimitadamente) à medida que $x$ se tornar cada vez mais próximo de $a$ pela seguinte notação:
$$\lim_{x\to a} f(x) = \infty$$
"

# ╔═╡ 1de985c0-115e-4d1d-874b-c124e760969a
md"""
!!! correct "Definição (informal) 3.3 - Limite infinito"
	Seja $f$ uma função definida em ambos os lados de $a$, exceto possivelmente no próprio $a$. Então:

	$$\lim_{x\to a} f(x) = \infty\tag{3}$$

	significa que podemos fazer os valores de $f(x)$ ficarem arbitrariamente grandes tornando $x$ suficientemente próximo de $a$, mas não igual a $a$.

	De maneira análoga, a expressão:

	$$\lim_{x\to a} f(x) = -\infty\tag{4}$$

	significa que podemos fazer os valores de $f(x)$ ficarem arbitrariamente grandes, porém negativamente, tornando $x$ suficientemente próximo de $a$, mas não igual a $a$.
"""

# ╔═╡ 8daf5929-81a4-4103-8da5-43b9304d6dbb
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig5.PNG", :width => 325))
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig6.PNG", :width => 300.5))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ 82798f4c-4d04-4e24-afac-9ea810191d3b
md"
* Definições similares podem ser dadas no caso de limites laterais:
$$\begin{eqnarray} \lim_{x\to a^{-}} f(x) = \infty &\qquad & \lim_{x\to a^{+}} f(x) = \infty \\ \lim_{x\to a^{-}} f(x) = -\infty &\qquad & \lim_{x\to a^{+}} f(x) = -\infty\end{eqnarray}$$
"

# ╔═╡ d7b9fb5f-b8f7-4d9f-99c6-f9a3c24acb7f
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig7.PNG", :width => 800))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ bd1e50f1-43f7-41d5-9e99-4abcd87961b4
md"""
!!! correct "Definição 3.4 - Assíntota vertical"
	A reta $x = a$ é denominada **assíntota vertical** da curva $y = f(x)$ se pelo menos uma das seguintes condições estiver satisfeita:

	$$\begin{eqnarray} \lim_{x\to a}f(x) = \infty &\qquad& \lim_{x\to a^{-}}f(x) = \infty &\qquad& \lim_{x\to a^{+}}f(x) = \infty \\ \lim_{x\to a}f(x) = -\infty &\qquad& \lim_{x\to a^{-}}f(x) = -\infty &\qquad& \lim_{x\to a^{+}}f(x) = -\infty\end{eqnarray}$$
"""

# ╔═╡ 36621df9-5ad5-49a6-a11d-345579dbab6b
md"
* Considere a função definida por:
$$y = \frac{2x}{x-3}$$
* Note que quando $x$ está próximo de 3 (mas é maior que 3), então, o denominador de $y$ é um número positivo pequeno e o numerador aproxima-se de 6
* Então, o quociente $2x/(x-3)$ é um número positivo grande
* Intuitivamente, temos:
$$\lim_{x\to 3^{+}} \frac{2x}{x-3}=\infty$$
* De maneira análoga, quando $x$ aproxima-se de 3 pela esquerda, o denominador é um número negativo pequeno
* O numerador, no entanto, continua sendo um número positivo e próximo de 6
* Portanto, a razão $2x/(x-3)$ é um número negativo grande, ou seja:
$$\lim_{x\to 3^{-}} \frac{2x}{x-3} = -\infty$$
* De acordo com a Definição 3.4, a reta $x = 3$ é uma assíntota vertical!
"

# ╔═╡ 42b19420-63f8-48a2-acd3-d6eb19802a09
begin
	plot(range(-0.5, 3, 100), x->2x/(x-3), lc=:indianred, label=L"y = \frac{2x}{x-3}")
	plot!(range(3, 5, 100), x->2x/(x-3), lc=:indianred, label=:none)
	vline!([0], lc=:black, lw=1, label=:none)
	vline!([3], lc=:blue, lw=2, label=L"x = 3")
	hline!([0], lc=:black, lw=1, label=:none)
end

# ╔═╡ 72f73843-2d81-45c5-ab87-799a61607b1e
md"
* Quando consideramos a função $f(x) = 1/x^2$, tínhamos que $f(x) \to \infty$ quando $x \to 0$ tanto pela esquerda quanto pela direita
* De modo que, apesar de nenhum dos limites existir, podíamos escrever $\lim_{x\to 0} (1/x^2) = \infty$
* Note que, neste último exemplo, os limites laterais (apesar de não existirem) são diferentes
* De modo que dizemos apenas que $\lim_{x\to 3} 2x/(x-3)$ não existe
"

# ╔═╡ 1e908e54-c21f-4a26-9828-dd143c8ef935
md"
$...................................................................................$
"

# ╔═╡ ef655b0d-615f-46ce-ad94-03e30bdc8989
md"
* A função $f(x) = \ln x$ também possui uma assíntota vertical em $x = 0$
* Neste caso temos:
$$\lim_{x\to 0^{+}} \ln x = -\infty$$
"

# ╔═╡ 39b22f2b-012e-41ef-ada4-d7d569af81f9
begin
	plot(range(0, 3, 100), x->log(x), lc=:indianred, label=L"y = \ln x")
	vline!([0], lc=:black, lw=1, label=:none)	
	hline!([0], lc=:black, lw=1, label=:none)
end

# ╔═╡ 8b8214c9-9d25-4066-a23e-6112a6b51208
md"
## Propriedades de limites
"

# ╔═╡ ec414a88-1a47-401c-9f7b-83853dff95bb
md"""
!!! info "Propriedades de limites"
	Supondo que $c$ seja uma constante e os limites

	$$\lim_{x \to a}f(x) \qquad \text{ e } \qquad \lim_{x\to a} g(x)$$

	existam, então:

	$$\begin{eqnarray}\lim_{x\to a}[f(x) \pm g(x)] &=& \lim_{x\to a} f(x) \pm \lim_{x\to a} g(x) \tag{5}\\
	\lim_{x\to a}[c f(x)] &=& c\lim_{x\to a} f(x)\tag{6}\\
	\lim_{x\to a}[f(x) \cdot g(x)] &=& \lim_{x\to a} f(x) \cdot \lim_{x\to a} g(x)\tag{7}\\
	\lim_{x\to a} \frac{f(x)}{g(x)} &=& \frac{\lim_{x\to a} f(x)}{\lim_{x\to a} g(x)}, \quad \text{ se } \lim_{x\to a} g(x) \neq 0\tag{8}\end{eqnarray}$$
"""	

# ╔═╡ 45a707ad-a4cc-4d0a-b4a3-d337147b35c6
md"
#### Exercício
"

# ╔═╡ 150ba0bb-c5e4-413f-a85e-28824a24cdad
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig8.PNG", :width => 800))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ 6d84603f-a24d-4548-97b2-8a96743a80f6
md"
> Considere o gráfico das funções $f$ e $g$ representadas na figura acima
>
> Calcule os seguintes limites, se existirem:
>
> (a) $\lim_{x\to -2} [f(x) + 5g(x)]$
>
> (b) $\lim_{x\to 1} [f(x) \cdot g(x)]$
>
> (c) $\lim_{x\to 2} \frac{f(x)}{g(x)}$
"

# ╔═╡ 1f8c01b5-0475-4c84-a7cf-2d1c91c181aa
md"""
!!! info "Propriedades adicionais de limites"
	$$\begin{eqnarray} \lim_{x\to a} [f(x)]^n &=& \left[\lim_{x\to a} f(x)\right]^n, \qquad n\in \mathbb{Z}_+ \tag{9} \\
	\lim_{x\to a} \sqrt[n]{f(x)} &=& \sqrt[n]{\lim_{x\to a}f(x)}, \qquad n\in \mathbb{Z}_+ \tag{10} \\
	\lim_{x\to a} c &=& c \tag{11} \\
	\lim_{x\to a} x &=& a \tag{12} \\
	\end{eqnarray}$$
	Note que no caso da propriedade de raiz, se $n$ for par, supomos que $\lim_{x\to a} f(x) > 0$
"""

# ╔═╡ 77aa5874-bf36-41fb-aa5b-b181c44ad01e
md"
* Temos, então, os seguintes limites especiais que serão úteis:
$$\begin{eqnarray}\lim_{x\to a}x^n &=& a^n, \qquad n\in \mathbb{Z}_+ \\
\lim_{x\to a}\sqrt[n]{x} &=& \sqrt[n]{a}, \qquad n\in \mathbb{Z}_+\end{eqnarray}$$
"

# ╔═╡ b3a8c8e7-5d5a-4435-b75d-02f3865647f6
md"""
> **Exercício**. Calcule os limites a seguir:
>
> (a) $\lim_{x\to 5} (2x^2 - 3x + 4)$
>
> (b) $\lim_{x\to -2} \frac{x^3 + 2x^2 - 1}{5-3x}$
"""

# ╔═╡ 574edc9a-9be3-46a3-9f39-5e84ccee559c
md"
---
### Substituição direta
"

# ╔═╡ aba0e327-dae9-4c62-9e97-34e37bae5952
md"
* As funções do exercício anterior são, respectivamente, polinomial e racional
* Note que, para estes casos, os limites calculados são os mesmos que obteríamos caso fizéssemos uma substituição direta
* Para a letra (a), $f(5) = 39 = \lim_{x\to 5} f(x)$, sendo $f(x) = 2x^2-3x+4$
* Para a letra (b), $g(-2) = -\frac{1}{11} = \lim_{x\to -2} g(x)$, sendo $g(x) = \frac{x^3+2x^2-1}{5-3x}$
* O método de substituição direta sempre funciona para funções do tipo polinomial e racional
"

# ╔═╡ 8a504e4a-5b6e-48bb-a096-e7da3e0ae731
md"""
!!! info "Propriedade de substituição direta"
	Se $f$ for uma função polinomial ou racional e $a$ estiver no domínio de $f$, então:

	$$\lim_{x\to a} f(x) = f(a)$$
"""

# ╔═╡ 396da3ea-7243-4fad-8991-5f7d8ed9e619
md"""
!!! warning "Funções contínuas em a"
	As funções que possuem a propriedade de substituição direta são chamadas de **contínuas em $a$**, que será nosso próximo tópico.
"""

# ╔═╡ 2e2f35ad-4462-42b9-8a80-2d2b4d5455b3
md"
* Nem todos os limites podem ser calculados por substituição direta
* Considere, por exemplo, o seguinte limite:
$$\lim_{x\to 1} \frac{x^2-1}{x-1}$$
"

# ╔═╡ 8d16ab07-ab4b-42d0-8944-e4dd29581d47
md"""
!!! info ""
	Se $f(x) = g(x)$ quando $x\neq a$, então, $\lim_{x\to a}f(x) = \lim_{x\to a} g(x)$, desde que o limite exista.
"""

# ╔═╡ 85524ada-312c-4211-8110-d396171637ca
md"
* Seja $g$ a função definida por:
$$g(x) = \begin{cases} x+1, & \qquad x\neq 1 \\ \pi, &\qquad x=1\end{cases}$$
* Calcule $\lim_{x\to 1} g(x)$
"

# ╔═╡ 54b1a11d-4b54-4d8c-9c66-16bed82c4361
begin	
	plot(range(-1, 4, 50), x->x+1, lc=:indianred, label=:none)			
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)	
	scatter!([(1, 2)], label=:none, m = (6, :white, stroke(1, :indianred)))
	scatter!([(1, π)], label=:none, m = (6, :indianred, stroke(1, :indianred)))
end

# ╔═╡ 64c52685-1d5b-476e-b9ce-4a4e901455ff
md"
* Da mesma forma, podemos calcular o seguinte limite:
$$\lim_{h\to 0}\frac{(3+h)^2-9}{h}$$
"

# ╔═╡ d9dee3d1-ea6d-4b19-818c-f6e005d4ef2b
begin	
	plot(range(-2, 2, 100), x->((3+x)^2-9)/x, lc=:indianred, label=L"f(h) = \frac{(3+h)^2-9}{h}")			
	vline!([0], lc=:black, lw=1, label=:none)
	hline!([0], lc=:black, lw=1, label=:none)	
	scatter!([(0, 6)], label=:none, m = (6, :white, stroke(1, :indianred)))	
end

# ╔═╡ 9c2885b2-060b-48c7-94bd-99f12503feff
md"
* Considere, agora, o seguinte limite:
$$\lim_{t\to 0} \frac{\sqrt{t^2+9}-3}{t^2}$$
"

# ╔═╡ fd2f0d95-35b3-4e3d-bb03-be389b490cb1
begin	
	plot(range(-2, 2, 100), x->(sqrt(x^2+9)-3)/(x^2), lc=:indianred, label=L"f(t) = \frac{\sqrt{t^2+9}-3}{t^2}")			
	vline!([0], lc=:black, lw=1, label=:none)			
	scatter!([(0, 1/6)], label=:none, m = (6, :white, stroke(1, :indianred)))	
end

# ╔═╡ 20500af0-bde8-4ae7-b12e-2d57485268c2
md"
### Limites laterais
"

# ╔═╡ a678e176-b313-44ed-8875-457ca0fecaf0
md"
* Para alguns limites, é melhor calcular primeiro os limites laterais
* É importante observar que as propriedades de limites são válidas também para limites laterais
"

# ╔═╡ ca161679-8d2e-4625-9bfd-969e71ca93f1
md"
> **Exercício.** Calcule, se existirem, os seguintes limites
>
> (a) $\lim_{x\to 0} |x|$
>
> (b) $\lim_{x\to 0} \frac{|x|}{x}$
>
> (c) $\lim_{x\to 4} f(x)$, sendo $f(x) = \begin{cases}\sqrt{x-4}, & \quad x>4 \\ 8-2x, & \quad x<4\end{cases}$
"

# ╔═╡ 19cbe0ad-14ad-4354-a73c-bf9fe7900cdc
md"
---
### Teorema do sanduíche
"

# ╔═╡ 5fd523a6-2c52-48f1-ba4a-3de7854db3a3
md"
* Os próximos teoremas descrevem a relação que existe entre limites de funções quando os valores de uma função são maiores ou iguais aos valores de outra
"

# ╔═╡ 2cb3efe3-a526-43a0-bb1d-438a721aa31d
md"""
!!! correct "Teorema 3.1"
	Se $f(x) \leq g(x)$ quando $x$ está próximo a $a$ (exceto possivelmente em $a$) e os limites de $f$ e de $g$ existem quando $x$ tende a $a$, então:

	$$\lim_{x\to a} f(x) \leq \lim_{x\to a} g(x) \tag{13}$$
"""

# ╔═╡ 7b218e35-4cbb-4c45-a32f-99691aac2e3f
md"""
!!! correct "Teorema 3.2 - Teorema do Sanduíche"
	Se $f(x) \leq g(x) \leq h(x)$ quando $x$ está próximo a $a$ (exceto possivelmente em $a$) e:

	$$\lim_{x\to a} f(x) = \lim_{x\to a} h(x) = L$$
	então:

	$$\lim_{x\to a} g(x) = L$$
"""

# ╔═╡ e56f2482-39ff-45f5-9aed-4e27498f7c3c
md"
* O Teorema do Sanduíche (Teorema do Confronto ou Teorema do Imprensamento) está ilustrado na figura abaixo
* Se $g(x)$ ficar imprensado entre $f(x)$ e $h(x)$ nas proximidades de $a$, e se $f$ e $h$ tiverem o mesmo limite $L$ em $a$, então, $g$ necessariamente terá o mesmo limite $L$ em $a$
"

# ╔═╡ 55c21443-40b5-4448-bb61-f5f68efdbdc7
md"""
$(Resource("https://raw.githubusercontent.com/pvfonseca/mtm_aplicada/main/notes/figures/aula3_fig9.PNG", :width => 800))
Fonte: Stewart, Clegg, Watson (2022) - Cálculo, vol. I
"""

# ╔═╡ c43b6ded-e91d-4b20-9998-fefcc3cc0104
md"
> **Exercício**
>
> Use o Teorema do Sanduíche para mostrar que $\lim_{x\to 0} x^2 \sin \frac{1}{x} = 0$
"

# ╔═╡ 84614f92-5ccf-48e2-994f-4f6598b3d5d8
begin	
	plot(range(-0.1, 0.1, 200), x->x^2, label=L"h(x) = x^2")			
	plot!(range(-0.1, 0.1, 200), x->-x^2, label=L"f(x) = -x^2")
	plot!(range(-0.1, 0.1, 200), x->(x^2)*sin(1/x), label=L"g(x) = x^2 \sin \frac{1}{x}", legend=:top)
	vline!([0], lc=:black, lw=1, label=:none)				
	hline!([0], lc=:black, lw=1, label=:none)
	scatter!([(0, 0)], label=:none, m = (6, :green, stroke(1, :green)))	
end

# ╔═╡ d03b20bb-a1f5-4a38-9834-9c8bfab5f505
md"
## 📚 Bibliografia

STEWART, J.; CLEGG, D.; WATSON, S. [Cálculo: volume I](https://app.minhabiblioteca.com.br/reader/books/9786555584097). 9.ed. São Paulo: Cengage Learning, 2022.

**Bibliografia complementar**

SPIVAK, M. Calculus. Cambridge University Press, 1994.
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
Plots = "~1.38.8"
PlutoUI = "~0.7.50"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.8.5"
manifest_format = "2.0"
project_hash = "e9be83a6c7fd21f04cfc4051871fb477d5cc6cf9"

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
deps = ["ColorTypes", "ColorVectorSpace", "Colors", "FixedPointNumbers", "Random", "SnoopPrecompile"]
git-tree-sha1 = "aa3edc8f8dea6cbfa176ee12f7c2fc82f0608ed3"
uuid = "35d6a980-a343-548e-a6ea-1d62b119f2f4"
version = "3.20.0"

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
git-tree-sha1 = "4423d87dc2d3201f3f1768a29e807ddc8cc867ef"
uuid = "28b8d3ca-fb5f-59d9-8090-bfdbd6d07a71"
version = "0.71.8"

[[deps.GR_jll]]
deps = ["Artifacts", "Bzip2_jll", "Cairo_jll", "FFMPEG_jll", "Fontconfig_jll", "GLFW_jll", "JLLWrappers", "JpegTurbo_jll", "Libdl", "Libtiff_jll", "Pixman_jll", "Qt5Base_jll", "Zlib_jll", "libpng_jll"]
git-tree-sha1 = "3657eb348d44575cc5560c80d7e55b812ff6ffe1"
uuid = "d2c73de3-f751-5644-a686-071e5b155ba9"
version = "0.71.8+0"

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
git-tree-sha1 = "3c837543ddb02250ef42f4738347454f95079d4e"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.3"

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
git-tree-sha1 = "2422f47b34d4b127720a18f86fa7b1aa2e141f29"
uuid = "23fbe1c1-3f47-55db-b15f-69d7ec21a316"
version = "0.15.18"

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
git-tree-sha1 = "6503b77492fd7fcb9379bf73cd31035670e3c509"
uuid = "4d8831e6-92b7-49fb-bdf8-b643e874388c"
version = "1.3.3"

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
deps = ["ColorSchemes", "Colors", "Dates", "Printf", "Random", "Reexport", "SnoopPrecompile", "Statistics"]
git-tree-sha1 = "c95373e73290cf50a8a22c3375e4625ded5c5280"
uuid = "995b91a9-d308-5afd-9ec6-746e21dbc043"
version = "1.3.4"

[[deps.Plots]]
deps = ["Base64", "Contour", "Dates", "Downloads", "FFMPEG", "FixedPointNumbers", "GR", "JLFzf", "JSON", "LaTeXStrings", "Latexify", "LinearAlgebra", "Measures", "NaNMath", "Pkg", "PlotThemes", "PlotUtils", "Preferences", "Printf", "REPL", "Random", "RecipesBase", "RecipesPipeline", "Reexport", "RelocatableFolders", "Requires", "Scratch", "Showoff", "SnoopPrecompile", "SparseArrays", "Statistics", "StatsBase", "UUIDs", "UnicodeFun", "Unzip"]
git-tree-sha1 = "f49a45a239e13333b8b936120fe6d793fe58a972"
uuid = "91a5bcdd-55d7-5caf-9e0b-520d859cae80"
version = "1.38.8"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "5bb5129fdd62a2bbbe17c2756932259acf467386"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.50"

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
git-tree-sha1 = "94f38103c984f89cf77c402f2a68dbd870f8165f"
uuid = "3bb67fe8-82b1-5028-8e26-92a6c54297fa"
version = "0.9.11"

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
git-tree-sha1 = "c6edfe154ad7b313c01aceca188c05c835c67360"
uuid = "3161d3a3-bdf6-5164-811a-617609db77b4"
version = "1.5.4+0"

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
# ╟─64369800-d1a2-11ed-04da-9712268f297f
# ╟─cdf12936-b45d-4f5c-a954-87c743c6d083
# ╟─c72aacad-3f25-4d82-9cd3-89a1d09ef5a2
# ╟─4fe2b3ea-6834-4ec4-8123-1c57c76f9c4e
# ╟─b1eb2efd-7b25-4db3-84c4-d395d2525726
# ╟─e32edb79-90c1-4f7c-8784-655517671227
# ╟─1c98c97d-4205-4125-8366-517ac9170445
# ╟─d83df195-f950-4ff1-99f0-355a2ec3371e
# ╟─f7f299f3-6466-468a-8efb-5e866cea87c9
# ╟─9f3870f1-3ced-42f7-aa46-c733ee70619f
# ╟─b24f8989-5849-4398-9da4-abb56a81ab58
# ╟─feb72847-f56c-4e46-be25-0f6e7532f464
# ╟─3f44eb1d-5eac-43f9-83ee-3d1402cfb769
# ╟─36c377fc-f76b-49db-986f-7cb0b0829fee
# ╟─41706370-645c-4a89-a9b8-15c25bcb18cd
# ╟─ad81f15f-f88e-425e-8f42-1dd419ff6122
# ╟─af1bf46c-80cd-4daa-803a-7e0935a6872a
# ╟─2629065b-eddc-4929-8293-73666f637c45
# ╟─6a294008-f2d6-43e4-b498-a83476716b4e
# ╟─7d2bedcb-a38e-47bf-9de3-957519de7803
# ╟─66e456f0-68a9-4eaa-b40c-072a5e3c5bc1
# ╟─0f9288cf-6c68-47ce-96bb-e0bb91ca02b4
# ╟─a539b60f-e122-4e30-bc55-020549602dcf
# ╟─ba3aa560-ef9a-44a8-bfdb-cb45c5e21ec6
# ╟─e078bb2f-1b59-4c66-b293-72c39de4c8d2
# ╟─dc3ef891-439f-42df-9465-7cff9480eebf
# ╟─c05b2971-99cc-49c5-a669-fe215478eaee
# ╟─8c66187e-39c7-4144-83eb-71ad96ab0ba3
# ╟─164d3d9a-c0ca-4c5c-9a93-2aa1ead66bfc
# ╟─f8c02a07-ccb6-4c2f-a5d8-9783b4843634
# ╟─bbf34216-9e7c-4701-9bd4-191e3836c5dc
# ╟─5bb03821-eeb9-47f5-85dd-81b7b8b06ec9
# ╟─021a60e0-2b89-4833-b34f-1d5d3856327b
# ╟─29764604-0719-4411-a1d5-b7e51c46225b
# ╟─83d13128-8917-4d86-a4c9-7088f2a1eac2
# ╟─5db4adc7-a879-48a4-aced-5ddadd6085c2
# ╟─f70a2010-faad-4677-9987-649d9c1a869d
# ╟─9cb382f3-7da6-45f7-9c2e-26728c79d831
# ╟─60862767-63d4-4b9b-a665-d982dc936009
# ╟─c6ecb81a-1512-48bd-a994-13acb14c44ab
# ╟─e8f9eab2-08c9-4621-b9c0-2af77fc88281
# ╟─2e6e1911-b5a7-4fd2-b43f-fcc5e0c8f195
# ╟─1de985c0-115e-4d1d-874b-c124e760969a
# ╟─8daf5929-81a4-4103-8da5-43b9304d6dbb
# ╟─82798f4c-4d04-4e24-afac-9ea810191d3b
# ╟─d7b9fb5f-b8f7-4d9f-99c6-f9a3c24acb7f
# ╟─bd1e50f1-43f7-41d5-9e99-4abcd87961b4
# ╟─36621df9-5ad5-49a6-a11d-345579dbab6b
# ╟─42b19420-63f8-48a2-acd3-d6eb19802a09
# ╟─72f73843-2d81-45c5-ab87-799a61607b1e
# ╟─1e908e54-c21f-4a26-9828-dd143c8ef935
# ╟─ef655b0d-615f-46ce-ad94-03e30bdc8989
# ╟─39b22f2b-012e-41ef-ada4-d7d569af81f9
# ╟─8b8214c9-9d25-4066-a23e-6112a6b51208
# ╟─ec414a88-1a47-401c-9f7b-83853dff95bb
# ╟─45a707ad-a4cc-4d0a-b4a3-d337147b35c6
# ╟─150ba0bb-c5e4-413f-a85e-28824a24cdad
# ╟─6d84603f-a24d-4548-97b2-8a96743a80f6
# ╟─1f8c01b5-0475-4c84-a7cf-2d1c91c181aa
# ╟─77aa5874-bf36-41fb-aa5b-b181c44ad01e
# ╟─b3a8c8e7-5d5a-4435-b75d-02f3865647f6
# ╟─574edc9a-9be3-46a3-9f39-5e84ccee559c
# ╟─aba0e327-dae9-4c62-9e97-34e37bae5952
# ╟─8a504e4a-5b6e-48bb-a096-e7da3e0ae731
# ╟─396da3ea-7243-4fad-8991-5f7d8ed9e619
# ╟─2e2f35ad-4462-42b9-8a80-2d2b4d5455b3
# ╟─8d16ab07-ab4b-42d0-8944-e4dd29581d47
# ╟─85524ada-312c-4211-8110-d396171637ca
# ╟─54b1a11d-4b54-4d8c-9c66-16bed82c4361
# ╟─64c52685-1d5b-476e-b9ce-4a4e901455ff
# ╟─d9dee3d1-ea6d-4b19-818c-f6e005d4ef2b
# ╟─9c2885b2-060b-48c7-94bd-99f12503feff
# ╟─fd2f0d95-35b3-4e3d-bb03-be389b490cb1
# ╟─20500af0-bde8-4ae7-b12e-2d57485268c2
# ╟─a678e176-b313-44ed-8875-457ca0fecaf0
# ╟─ca161679-8d2e-4625-9bfd-969e71ca93f1
# ╟─19cbe0ad-14ad-4354-a73c-bf9fe7900cdc
# ╟─5fd523a6-2c52-48f1-ba4a-3de7854db3a3
# ╟─2cb3efe3-a526-43a0-bb1d-438a721aa31d
# ╟─7b218e35-4cbb-4c45-a32f-99691aac2e3f
# ╟─e56f2482-39ff-45f5-9aed-4e27498f7c3c
# ╟─55c21443-40b5-4448-bb61-f5f68efdbdc7
# ╟─c43b6ded-e91d-4b20-9998-fefcc3cc0104
# ╟─84614f92-5ccf-48e2-994f-4f6598b3d5d8
# ╟─d03b20bb-a1f5-4a38-9834-9c8bfab5f505
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
