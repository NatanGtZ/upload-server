import { uploadImage } from '@/app/functions/upload-image'
import { isRight, unwrapEither } from '@/shared/either'
import type { FastifyPluginAsyncZod } from 'fastify-type-provider-zod'
import { z } from 'zod'

export const healthCheckRoute: FastifyPluginAsyncZod = async server => {
  server.get('/health-check', async (request, reply) => {
    await reply.status(200).send({ message: 'OK' })
  })
}
