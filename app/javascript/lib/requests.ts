import axios, { AxiosInstance, AxiosResponse } from 'axios'
import moize from 'moize'

const csrfToken = moize((): string => {
  return document.querySelector('meta[name=\'csrf-token\']')?.getAttribute('content') ?? ''
})

const axiosInstance = moize((): AxiosInstance => {
  return axios.create({ headers: { 'X-CSRF-TOKEN': csrfToken() } })
})

export const getBooks = async (): Promise<AxiosResponse> => {
  return await axiosInstance().get('/books')
}

export const getResults = async (): Promise<AxiosResponse> => {
  return await axiosInstance().get('/results')
}

export const createRanking = async (ids: number[]): Promise<AxiosResponse> => {
  return await axiosInstance().post('/rankings', { order: ids })
}
