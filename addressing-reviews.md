# Reviewer's Comments

Changes to the paper are shown highlighted.

## Major Comments

> What is the estimated error (uncertainty) on the density of the new EOS that the authors present in this paper? Is it on ~1% level? or ~0.1% level? Many readers would be interested to know this. The authors should mention this in this paper.

The error in the equation of state varies depending on the original data source.
We defer to the original authors on this:

- For the region encompassed by the IAPWS data (Wagner and Pruß 2002), the density uncertainty is approximately 0.01% (liquid and solid), 0.03--0.1% (vapour), and up to 0.5% in the region around the critical point and in the supercritical fluid phase.     See §6.3.2, in particular Fig 6.1, in that paper for a more detailed breakdown of these errors. Extrapolating beyond the table and assuming that the uncertainty continues to increase at higher temperatures and pressures, we estimate that the error is closer to 1%.
- For the supercritical fluid, plasma and superionic phases in the data of French et al (2009), they state that "the QMD EOS is accurate up to 1% for the conditions relevant for the giant planet’s interiors of our solar system."
- Measurements of the ice VII phase have errors of between 0.003% and 0.5% in the tabulated data of Sugimura et al (2010).
- At higher pressures where no measurements exist, it is not possible to give a meaningful uncertainty estimate, but we do not treat the temperature dependence here anyway.

We therefore believe our equation of state to have an error of less than 0.1% in the liquid phase, 0.5% around the critical point, and closer to 1% at higher temperatures and pressures.

We have updated the paper to include these numbers in the equation of state section (§2.2.3, pp. 8--9).

> It would be helpful if the authors could make their new EOS publicly available in an easy-to-use format, such as a table. This will facilitate other researchers to reproduce the results in this paper, and compare to other H2O EOS such as the (Sarah Steward et al 2010) 5-Phase H2O EOS on their own.

Yes, we will release the equation of state data, as well as the code with which we generated the models. As the equation of state data and code are Git repositories and will also be used in our next paper, we would prefer to make them available on a platform like Github rather than as MNRAS supplementary data. For this reason we will not be including the data with the paper itself but will release it separately later this year.

We have not made any changes to the paper related to this point.

> The surface pressures in the authors’ models seem to span over a big range 1bar-10^5bar and set as a free parameter. However, in reality, the surface pressure should be set according to the observational constraint, that is the depth of the atmosphere to which light can no longer transmit through. To what depth or pressure level does the current radius measurement of exoplanets probe down to? (assuming an H2O-atmosphere) This should be discussed.

The depth of the opacity surface, and hence the surface pressure, depends on the wavelength which is used to probe the atmosphere. A monochromatic radius measurement therefore provides little information about the atmospheric extent. Madhusudhan & Redfield (2015) discuss planets with H$_2$O-rich atmospheres, and in §3.1.2 they describe the use of measurements both in and out of opacity windows to determine the atmospheric thickness. The pressure to which these measurements probe vary from ~0.1 bar (in regions of high opacity; that is, outside an atmospheric window) to ~100 bar (within such a window). Our models go beyond this pressure range, and are therefore appropriate for modelling the behaviour of the structure of the planet below the observable opacity surface.

The reviewer is quite right that any attempt to interpret observations based on these models must necessarily take the surface pressure into account rather than treating it as a free parameter. Ideally, such models would include a full treatment of an atmospheric (volatile) layer, and the pressure and temperature at the base of this layer would be used as the boundary conditions for the interior model. This is an approach already being taken by other authors, such as Rogers & Seager (2010b). Our aim in this paper was to show that even in the presence of a thick atmosphere (surface pressures of tens or hundreds of bars), the effect of including temperature dependence still produces a significant change to the interior radius when compared to simpler models.

We have updated the paper with the points above (§4, pp. 14--15), clarifying that the choice of surface pressures in our models is motivated by the range to which current surface measurements probe. We have also strengthened the discussion of opacity windows in the final paragraphs, explaining how these windows may provide a view through the atmosphere to a physical solid/liquid surface in the absence of a cloud deck.

We also now mention how our models serve as a useful addition to the work of Kipping et al (2013). In that paper, they provide a simple way to estimate the thickness of a planet's atmosphere based on mass and radius measurements alone. We observe that incorporating an estimate of the planet's temperature should give better constraints on this, as the interior may be larger than previously thought once the temperature structure is included.

> A table for the opacity of H2O (especially, the vapor phase and supercritical fluid phase), in the relevant pressure-temperature range would be very useful if the authors really want to compare their models to observational results. Since H2O is a volatile component, It is difficult to separate it into an envelope part and an atmosphere part and draw an artificial boundary in terms of pressure. A thorough treatment of it all the way until the opacity surface is necessary. Cloud formation in the atmosphere may also be considered as an effect on the radius. Opalescent turbidity (such as those seems around black-smokers in deep ocean on Earth) happening around critical point may also affect the surface optical property of the planet. Even if the opacity of H2O is not addressed in this paper, this should be a future direction of improvement.

Here the reviewer has raised some excellent points and anticipated the direction in which we are continuing. Although we do not intend to treat opacity within this paper, it is a good next step. We would like to investigate to what degree such a planet is convective and therefore make a clearer distinction between atmosphere and interior. This will require at least a simple radiative treatment to assess at what depth the planet becomes unstable against convection. Howe et al (2014) have a paper on core-envelope decompositions for icy/watery planets, but their models do not treat the temperature profile and associated phase changes throughout the planet.

We have updated the paper to strengthen the discussion on the volatile nature of H$_2$O, addressing it in the context of the surface pressure changes discussed above (§4, pp. 14--15). In particular, we have noted the reviewer's concerns about the presence of clouds and turbidity. We included comments about how observations of hot exoplanets can partially circumvent the problem of clouds.

> The authors may want to mention and compare the physical implications of the existence of different phases of water in their models. (See Anisimov and Sengers, Near-critical behavior of aqueous systems, 2004). For example, the properties of water near supercritical point are very different from ambient liquid water. Due to destruction of Hydrogen-bonds at higher temperatures, the water near the supercritical point becomes a poor solvent for electrolytes, however, a good solvent for non-polar molecules. Its electric property also changes from a high dielectric to low dielectric. The strong density fluctuations around the critical point also causes opalescent turbidity. Those change of properties will affect the habitability and the type of habitability of the particular planet of interest. There are also abrupt changes of properties of cold liquid water above 0.2 GPa (for example, viscosity, self-diffusion, compressibility, etc.) (See Kruse and Dinjus, Hot compressed water as reaction medium and reactant, 2007). Therefore, with the proposed new H2O EOS, the authors may want to discuss the implications of each scenario on the habitability of the planet.

This is a very interesting line of enquiry, although a little beyond the scope of this paper. We have added brief comments on this topic (§3.4, pp. 13--14), and would be interested in continuing future work in this direction. Another application could be to link the habitability implications at various depths to the thermal evolution of the planet.

## Minor comments

> The authors should update their references. They should try to refer directly to the refereed journal link instead of arXiv link. For example:
>
> - Rockers 2014
> - Rogers 2014 (the online link is missing)
> - Zeng & Sasselov 2014 (the online link is missing)

TODO: We have checked and updated the references as requested.

## Figure alterations

1. The text incorrectly indicated that figure 8 showed models that were 100% water.
    They are actually 30% water over an Earth-like core, and we have updated the text appropriately.
2. Figure 8 now cover a surface pressure range of 1--1000 bar instead of 10-10000 bar.
3. The centre-bottom panel in figure 9 now shows 30% water models rather than 20% in order to match the models used in figure 8.
