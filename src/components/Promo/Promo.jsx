import React from 'react'
import Carousel from '../Carousel/Carousel'
import { sliderData } from '../../sliderData'

const Promo = () => {

  return (
    <article className='promo'>
      <Carousel sliderData = { sliderData }/>
      <div className='promo__top-content'>
        <p className='promo__desc'>
          ТОО «DSA Engineering Group» является инжиниринговой компанией и
          оказывает услуги по подбору и поставке материалов и оборудования для
          предприятий в области ЖКХ, тепловых сетей, нефтегазовой, химической и
          водопроводной отраслей, в связи, с чем предлагаем к поставке
          оборудование Российского, Белорусского, Китайского и Казахстанского
          производства.
        </p>
      </div>
    </article>
  )
}

export default Promo