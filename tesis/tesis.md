\documentclass[spanish,12pt,twoside]{book}
%\documentclass[spanish,12pt,twoside,draft]{book}
\usepackage{amsmath,latexsym,amssymb,color,epsfig,multirow,amsthm,units,pifont,fancyvrb,setspace}
\usepackage[spanish,mexico]{babel} %para los acentitos y ?
\usepackage[latin1]{inputenc}  % acentos y ?
\usepackage[justification=centering]{caption} %Para mejor manejo de captions
\spanishdecimal{.}
\usepackage[margin=2.5cm]{geometry}
\usepackage{fancyhdr}
\pagestyle{fancy}
\parskip 10pt %por cada enter le pisa un espacio de 10
\newcommand{\real}{\mathbb{R}}
\newcommand{\ttt}[1]{\texttt{#1}}

\theoremstyle{definition}
\newtheorem{dfn}{Definici\'on}[section]
\newtheorem*{demos}{Demostraci\'on}
\newtheorem{ej}{Ejemplo}[section]
\newtheorem{prop}{Proposici\'on}[section]
\newtheorem{nteo}{Teorema}[section]
\newtheorem{ncor}{Corolario}[section]
\newtheorem{nlema}{Lema}[section]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{document}
\include{disclosure}
\addtolength{\voffset}{-1in}
\frontmatter
\title{\textbf{Criptografía Tropical}}
\author{Jessica Paola Barbosa Torres}
\date{}
\maketitle
%\include{dedicatoria}
\addtolength{\voffset}{-1in}
\pagestyle{fancy}
%\include{agradecimientos}
%\include{prologo}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\tableofcontents
\mainmatter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\fancyhead{}
\fancyfoot{}
\fancyhead[LE,RO]{\tiny{\slshape \rightmark}}
\fancyhead[L]{ITAM}
\fancyhead[R]{Jessica Barbosa}
\fancyhead[LO,RE]{\slshape \leftmark}
\fancyfoot[RO,LE]{\thepage}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%\input{intro.tex}
%\input{cripto.tex}
%\input{cripto2.tex}
%\input{estructuras.tex}
%\input{polinomiostropicales.tex} %Tbn es parte del capítulo de estructuras tropicales
%\input{sistemaslineales.tex}
%\input{algoritmos.tex}
%\input{algoritmos2.tex}
%\input{conclusiones.tex}
%\appendix
%\input{boolean.tex}
%\input{codigo.tex}
%\input{codigo2.tex}
%\input{codigo3.tex}
%\input{codigo4.tex}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\backmatter
\renewcommand\refname{Bibliograf\'ia}
\addcontentsline{toc}{chapter}{Bibliografía}
\begin{thebibliography}{50}

 		\bibitem{lind} Akian, M., Gaubert, S. y Guterman, A. (2009) \emph{Linear Independence Over Tropical Semirings and Beyond} en Proceedings of the International Conference on Tropical and Idempotent Mathematics. Volumen 495, pp. 1-38, Series in Contemporary Mathematics. AMS.

    \bibitem{perr} Berstel, J., Perrin, D. y Reutenauer, C. (2011) \emph{Codes and Automata - Theory of Codes}. Volumen 129 de la Encyclopedia of Mathematics and its Applications. Cambridge Univ. Press.
    
 		\bibitem{rsa} Boneh, D. (1999) \emph{Twenty Years of Attacks on the RSA Cryptosystem} en Notices of the American Mathematical Society, Volumen 46, No. 2, pp. 203-213. AMS.%, Ann Arbor.

		\bibitem{maxls} Butkovi\v{c}, P. (2010) \emph{Max-linear Systems: Theory and Algorithms}. Springer-Verlag.%, Londres.

 		\bibitem{cook} Cook, S. (1971) \emph{The complexity of theorem proving procedures} en Proceedings of the Third Annual ACM Symposium on Theory of Computing, pp. 151-158. ACM.%, Nueva York.

 		\bibitem{cravioto} Cravioto, M. (2008) \emph{Problemas $\mathcal{NP}-completos$}. Tesis para obtener el título de Licenciada en Matemáticas Aplicadas. ITAM.

		\bibitem{rank} Develin, M., et al. (2005) \emph{On the Rank of a Tropical Matrix}. Combinatorial and Computational Geometry, Vol. 52. MSRI Publications.

		\bibitem{fraleigh} Fraleigh, J. (2002) \emph{A First Course in Abstract Algebra}. Addison Wesley, 7ma. edición.

		\bibitem{juegos} Gaubert, S, et al. (2011) \emph{Tropical Lineal-Fractional Programming and Parametric Mean Payoff Games}. Preimpresión. Disponible en \ttt{http://arxiv.org/pdf/1101.3431.pdf}, consultado el 25 de agosto de 2011.

		\bibitem{fund} Grigg, N. y Manwaring, N. (2007) \emph{An Elementary Proof of the Fundamental Theorem of Tropical Algebra}. Preimpresión. Disponible en \ttt{http://arxiv.org/ pdf/0707.2591v1.pdf}, consultado el 25 de agosto de 2011.

		\bibitem{art} Grigoriev, D. y Shpilrain, V. (2010) \emph{Tropical Cryptography}. Preimpresión. Disponible en \ttt{http://www.sci.ccny.cuny.edu/$\sim$shpil/tropical.pdf}, consultado el 25 de agosto de 2011.

		\bibitem{tropicurv} Haase, C., Musiker, G y Yo, J. (2011) \emph{Linear Systems on Tropical Curves}. Disponible en \ttt{http://arxiv.org/pdf/0909.3685v1.pdf}, consultado el 25 de agosto de 2011.

 		\bibitem{quant} Hogg, T. (1999) \emph{Solving Highly Constrained Search Problems with Quantum Computers} en Journal of Artificial Intelligence Research, Volumen 10, pp. 39-66. AAAI Press.%, Toronto.

    \bibitem{mult} Johnson, M. y Kambites, M. (2009) \emph{Multiplicative Structure of $2\times 2$ Tropical Matrices}. Reporte técnico disponible en \ttt{http://arxiv.org/pdf/0907.0314}, consultado el 25 de agosto de 2011.
    
		\bibitem{kahn} Kahn, D. (1996) \emph{The Codebreakers: The Comprehensive History of Secret Communication from Ancient Times to the Internet}. Scribner, 2da. edición.

		\bibitem{des} Kammer, R. (1999) \emph{Data Encryption Standard (DES)}, FIPS-Pub.46-3. U.S. Department of Commerce. National Institute of Standards and Technology%, Washington D.C.
	  
	  \bibitem{pde} Kato, T. (2011) \emph{An Asymptotic Comparison of Differentiable Dynamics and Tropical Geometry}. Mathematical Physics, Analysis and Geometry. Volumen 14, No.1, pp.39-82. Springer

	  \bibitem{kerck} Kerckhoffs, A. (1883) \emph{La Cryptographie Militaire}. Journal des sciences militaires, Volumen IX, pp. 5-38, disponible en \ttt{http://www.petitcolas.net/ fabien/kerckhoffs/crypto\_militaire\_1.pdf}, consultado el 11 de mayo de 2012.

		\bibitem{artescit}  Kelly, T.(1998) \emph{The Myth of the Skytale} en Cryptologia, Volumen 22, No. 3, pp. 244-260. Taylor \& Francis.%, Filadelfia.
		
		\bibitem{lewal} Lewal, J. (1881) \emph{Études De Guerre. Tactique Des Renseignement}. Disponible en \ttt{http://archive.org/details/tudesdeguerreta01lewagoog}, consultado el 11 de mayo de 2012.

		\bibitem{dequant}  Litvinov, G. (2007) \emph{The Maslov Dequantization, Idempotent and Tropical Mathematics: A brief introduction} en Journal of Mathematical sciences. Volumen 140, No. 3, pp. 426-444. Springer.

		\bibitem{diane} Maclagan, D. y Sturmfels, B. (2009) \emph{Tropical Geometry}. Preimpresión. Disponible en:  \ttt{http://homepages.warwick.ac.uk/staff/ D.Maclagan/papers/TropicalBook.pdf}, consultado el 25 de agosto de 2011.

		\bibitem{criptolibro} Menezes,A., Van Oorschot, P. y Vanstone, S. (2001) \emph{Handbook of Applied Cryptography}. CRC Press, 5a. reimpresión.
				
		\bibitem{mik} Mikhalkin, G. (2006) \emph{Tropical Geometry and its Applications}. Disponible en:  \ttt{http://arxiv.org/abs/math.AG/0601041}, consultado el 25 de agosto de 2011.
						
		\bibitem{stat} Pachter, L. y Sturmfels, B. (2004) \emph{Tropical Geometry of Statistical Models}.
Proceedings of the National Academy of Sciences of the USA. Volumen 101, No. 46, pp. 16132-16137. PNAS.

 		\bibitem{pin} Pin, J.-E. (1994) \emph{Tropical semirings} en Idempotency, Volumen 11 de Publ. Newton Inst., pp. 50-69. Cambridge Univ. Press.

 		\bibitem{kasiski} Pommerening, K. (2006) \emph{Kasiski's Test: Couldn't the Repetitions be by Accident?} en Cryptologia, Volumen 30, No. 4, pp. 346-352. Taylor \& Francis.%, Filadelfia.

 		\bibitem{puente} Puente, M. J. (2010) \emph{Tropical Linear Maps on the Plane}. Preimpresión  Disponible en:  \ttt{http://arxiv.org/pdf/0907.2811v2.pdf}, consultado el 25 de agosto de 2011.

 		\bibitem{gamboa} Rajaraman, A., Leskovec, J. y Ullman, J. (2012) \emph{Mining of Massive Datasets}. Disponible en:  \ttt{http://i.stanford.edu/~ullman/mmds.html}, consultado el 26 de agosto de 2012.

		\bibitem{strum} Richter-Gebert,J., Sturmfels, B. y Theobald, T. (2003) \emph{First Steps in Tropical Geometry}. Disponible en:  \ttt{http://arxiv.org/abs/ math.AG/0306366}, consultado el 25 de agosto de 2011.
		
		\bibitem{automat} Simon, I. (1998) \emph{Recognizable Sets With Multiplicities in the Tropical Semiring} en Lecture Notes in Computer Science. Volumen 324, pp. 107-120. Springer.

		\bibitem{app} Speyer, D. y Sturmfels, B. (2004) \emph{Tropical Mathematics}. Notas sobre una conferencia dictada por Sturmfels en el Clay Mathematics Institute. Disponible en:  \ttt{http://arxiv.org/pdf/math/0408099v1.pdf}, consultado el 25 de agosto de 2011.

 		\bibitem{stick} Stickel, E. (2005) \emph{A New Method for Exchanging Secret Keys} en las memorias de la Third International Conference on Information Technology and Appplications (ICITA05), Vo\-lu\-men 2, pp. 426-430. IEEE Computer Society.%, Los Alamitos. 

		\bibitem{sueto} Suetonio, C. (¿119-122?) \emph{Vidas de los Césares}. Ediciones Catedra, 3a. edición. %, Madrid
		\bibitem{kama} Vatsayana. (2011) \emph{The Kama Sutra of Vatsyayana}. Empire Books. Pág. 7.

		\bibitem{boole} Whitesitt, J. (2010) \emph{Boolean Algebra and its Applications}. Dover Publications.
\end{thebibliography}

%m2tex
%http://www.mathworks.com/matlabcentral/fileexchange/24515-m-code-to-latex-converter
%Matlab 7.5
 % 	\bibitem{semirings} Hebisch, U. y Weinert, H. (2009) \emph{Semirings: Algebraic Theory and Applications in Computer Science}. Series in Algebra, Vol. 5. World Scientific Publishing, Singapur.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\end{document}
